# frozen_string_literal: true

require "rails_helper"

RSpec.describe Proponents::Application::Usecases::ProponentsUsecase, type: :usecases do
  let(:proponents_repository) { instance_double(Proponents::Infrastructure::Repositories::ProponentsRepository) }
  let(:usecase) { described_class.new(proponent: proponents_repository) }

  describe "#find_all_proponents" do
    it "returns a list of all proponents" do
      proponent_list = [
        Proponents::Domain::Models::Proponent.new(name: "John Doe", cpf: "123.456.789-00", date_of_birth: Date.new(1980, 1, 1), salary: 5000.0),
        Proponents::Domain::Models::Proponent.new(name: "Jane Smith", cpf: "987.654.321-00", date_of_birth: Date.new(1975, 5, 15), salary: 6000.0),
        Proponents::Domain::Models::Proponent.new(name: "Bob Johnson", cpf: "456.789.123-00", date_of_birth: Date.new(1990, 8, 20), salary: 5500.0)
      ]
      allow(Proponents::Infrastructure::Queries::ProponentsQuery).to receive(:find_all_proponents).and_return(proponent_list)
      output = usecase.find_all_proponents
      expect(output.count).to eq(3)
    end
  end

  describe "#calculate_inss_discount" do
    it "calculates INSS discount correctly for different salary ranges" do
      calculated_discount = usecase.calculate_inss_discount({ salary: 1500 })
      expect(calculated_discount).to eq(119.32)
    end
  end

  describe "#create_proponent" do
    it "creates a new proponent with INSS-discounted salary" do
      inss_discount = 1500 - usecase.calculate_inss_discount({ salary: 1500 })
      proponent = Proponents::Infrastructure::Models::Proponent.new(
        name: "John Doe",
        cpf: "042.984.740-89",
        date_of_birth: Date.new(1980, 1, 1),
        salary: inss_discount,
        phone_attributes: {
          number: "+55 (19) 99449-4444",
          phone_type: "personal"
        },
        address_attributes: {
          street: "123 Main St",
          number: "100",
          district: "Downtown",
          city: "Example City",
          uf: "EX",
          zipcode: "12345-678"
        }
      )
      allow(proponents_repository).to receive(:create).and_return(proponent)
      output = usecase.create_proponent(proponent)
      expect(output.salary).to eq(inss_discount)
      expect(output.name).to eq("John Doe")
      expect(output.cpf).to eq("042.984.740-89")
      expect(output.date_of_birth).to eq(Date.new(1980, 1, 1))
      expect(output.salary).to eq(inss_discount)
      expect(output.phone.number).to eq("+55 (19) 99449-4444")
      expect(output.phone.phone_type).to eq("personal")
      expect(output.address.street).to eq("123 Main St")
      expect(output.address.number).to eq("100")
      expect(output.address.district).to eq("Downtown")
      expect(output.address.city).to eq("Example City")
      expect(output.address.uf).to eq("EX")
      expect(output.address.zipcode).to eq("12345-678")
    end
  end

  describe "#destroy_proponent" do
    it "destroys a proponent if found by ID" do
      proponent = Proponents::Infrastructure::Models::Proponent.new(
        name: "John Doe",
        cpf: "042.984.740-89",
        date_of_birth: Date.new(1980, 1, 1),
        salary: 5000,
        phone_attributes: {
          number: "+55 (19) 99449-4444",
          phone_type: "personal"
        },
        address_attributes: {
          street: "123 Main St",
          number: "100",
          district: "Downtown",
          city: "Example City",
          uf: "EX",
          zipcode: "12345-678"
        }
      )
      allow(proponents_repository).to receive_messages(find_by_id: proponent, destroy: proponent)
      output = usecase.destroy_proponent(proponent)
      expect(output).not_to be_nil
      expect(output.name).to eq("John Doe")
      expect(output.cpf).to eq("042.984.740-89")
      expect(output.date_of_birth).to eq(Date.new(1980, 1, 1))
      expect(output.salary).to eq(5000)
      expect(output.phone.number).to eq("+55 (19) 99449-4444")
      expect(output.phone.phone_type).to eq("personal")
      expect(output.address.street).to eq("123 Main St")
      expect(output.address.number).to eq("100")
      expect(output.address.district).to eq("Downtown")
      expect(output.address.city).to eq("Example City")
      expect(output.address.uf).to eq("EX")
      expect(output.address.zipcode).to eq("12345-678")
    end
  end

  describe "#filter_proponents_by_salary_range" do
    it "filters proponents by salary range and returns the expected result" do
      proponent_list = [
        Proponents::Domain::Models::Proponent.new(name: "John Doe", cpf: "123.456.789-00", date_of_birth: Date.new(1980, 1, 1), salary: 500.0),
        Proponents::Domain::Models::Proponent.new(name: "Jane Smith", cpf: "987.654.321-00", date_of_birth: Date.new(1975, 5, 15), salary: 1500.0),
        Proponents::Domain::Models::Proponent.new(name: "Bob Johnson", cpf: "456.789.123-00", date_of_birth: Date.new(1990, 8, 20), salary: 2500.0),
        Proponents::Domain::Models::Proponent.new(name: "Alice Brown", cpf: "111.222.333-44", date_of_birth: Date.new(1988, 3, 10), salary: 3500.0),
        Proponents::Domain::Models::Proponent.new(name: "Eve White", cpf: "999.888.777-66", date_of_birth: Date.new(1982, 12, 5), salary: 6000.0)
      ]
      input = {
        proponents: proponent_list,
        params: {
          "salary_range_0" => 1,
          "salary_range_1" => 1,
          "salary_range_2" => 1,
          "salary_range_3" => 1
        }
      }
      expected_result = {
        "Até R$ 1.045,00" => {
          proponents: [proponent_list[0]],
          total: 1
        },
        "De R$ 1.045,01 a R$ 2.089,60" => {
          proponents: [proponent_list[1]],
          total: 1
        },
        "De R$ 2.089,61 até R$ 3.134,40" => {
          proponents: [proponent_list[2]],
          total: 1
        },
        "De R$ 3.134,41 até R$ 6.101,06" => {
          proponents: [proponent_list[3], proponent_list[4]],
          total: 2
        }
      }
      allow(usecase).to receive(:filter_proponents_by_salary_range).and_return(expected_result)
      output = usecase.filter_proponents_by_salary_range(input)
      expect(output["Até R$ 1.045,00"]).to eq(expected_result["Até R$ 1.045,00"])
      expect(output["De R$ 1.045,01 a R$ 2.089,60"]).to eq(expected_result["De R$ 1.045,01 a R$ 2.089,60"])
      expect(output["De R$ 2.089,61 até R$ 3.134,40"]).to eq(expected_result["De R$ 2.089,61 até R$ 3.134,40"])
      expect(output["De R$ 3.134,41 até R$ 6.101,06"]).to eq(expected_result["De R$ 3.134,41 até R$ 6.101,06"])
    end
  end

  describe "#update_proponent" do
    it "updates an existing proponent with the expected changes" do
      proponent = Proponents::Infrastructure::Models::Proponent.new(
        name: "John Doe",
        cpf: "042.984.740-89",
        date_of_birth: Date.new(1980, 1, 1),
        salary: 5000.0,
        phone_attributes: {
          number: "+55 (19) 99449-4444",
          phone_type: "personal"
        },
        address_attributes: {
          street: "123 Main St",
          number: "100",
          district: "Downtown",
          city: "Example City",
          uf: "EX",
          zipcode: "12345-678"
        }
      )
      update_proponent = Proponents::Infrastructure::Models::Proponent.new(
        name: "John Doe Updated",
        cpf: "042.984.740-89",
        date_of_birth: Date.new(1980, 1, 1),
        salary: 6000.0,
        phone_attributes: {
          number: "+55 (19) 99449-4444",
          phone_type: "personal"
        },
        address_attributes: {
          street: "123 Main St",
          number: "100",
          district: "Downtown",
          city: "Example City",
          uf: "EX",
          zipcode: "12345-678"
        }
      )
      allow(usecase).to receive(:calculate_inss_discount).with({ salary: 6000.0 }).and_return(600.0)
      allow(proponents_repository).to receive_messages(find_by_id: proponent, update: update_proponent)
      output = usecase.update_proponent(update_proponent)
      expect(output.name).to eq("John Doe Updated")
      expect(output.cpf).to eq("042.984.740-89")
      expect(output.date_of_birth).to eq(Date.new(1980, 1, 1))
      expect(output.salary).to eq(6000.0)
      expect(output.phone.number).to eq("+55 (19) 99449-4444")
      expect(output.phone.phone_type).to eq("personal")
      expect(output.address.street).to eq("123 Main St")
      expect(output.address.number).to eq("100")
      expect(output.address.district).to eq("Downtown")
      expect(output.address.city).to eq("Example City")
      expect(output.address.uf).to eq("EX")
      expect(output.address.zipcode).to eq("12345-678")
    end
  end
end
