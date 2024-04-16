import IMask from "imask";
import { Controller } from "@hotwired/stimulus";

export class ProponentFormController extends Controller {
  static targets = [
    "cpf",
    "zipcode",
    "street",
    "district",
    "city",
    "uf",
    "number",
    "salary",
  ];

  cpfTarget: HTMLInputElement;
  zipcodeTarget: HTMLInputElement;
  streetTarget: HTMLInputElement;
  districtTarget: HTMLInputElement;
  cityTarget: HTMLInputElement;
  ufTarget: HTMLInputElement;
  numberTarget: HTMLInputElement;
  salaryTarget: HTMLInputElement;

  connect(): void {
    IMask(this.cpfTarget, {
      mask: "000.000.000-00",
    });

    IMask(this.zipcodeTarget, {
      mask: "00000-000",
    });

    IMask(this.salaryTarget, {
      mask: Number,
      scale: 2,
      signed: false,
      thousandsSeparator: "",
    });

    IMask(this.numberTarget, {
      mask: "+55 (00) 00000-0000",
    });
  }

  async onCepChange() {
    const zipcode = this.zipcodeTarget.value;
    if (zipcode.length === 9) {
      const param = zipcode.replace("-", "");
      try {
        const response = await fetch(`https://viacep.com.br/ws/${param}/json/`);
        const data = await response.json();
        if (!data.erro) {
          this.streetTarget.value = data.logradouro;
          this.districtTarget.value = data.bairro;
          this.cityTarget.value = data.localidade;
          this.ufTarget.value = data.uf;
        } else {
          this.streetTarget.value = "";
          this.districtTarget.value = "";
          this.cityTarget.value = "";
          this.ufTarget.value = "";
        }
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    }
  }
}
