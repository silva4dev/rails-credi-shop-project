import IMask from 'imask'
import { Controller } from '@hotwired/stimulus'

export class ProponentFormController extends Controller {
  static targets = [
    'cpf',
    'zipcode',
    'street',
    'district',
    'city',
    'uf',
    'number',
    'salary'
  ]

  cpfTarget: HTMLInputElement
  zipcodeTarget: HTMLInputElement
  streetTarget: HTMLInputElement
  districtTarget: HTMLInputElement
  cityTarget: HTMLInputElement
  ufTarget: HTMLInputElement
  numberTarget: HTMLInputElement
  salaryTarget: HTMLInputElement

  connect (): void {
    IMask(this.cpfTarget, {
      mask: '000.000.000-00'
    })

    IMask(this.zipcodeTarget, {
      mask: '00000-000'
    })

    IMask(this.salaryTarget, {
      mask: Number,
      radix: '.',
      min: 1,
      max: 9999999.99,
      normalizeZeros: true,
      padFractionalZeros: true
    })

    IMask(this.numberTarget, {
      mask: '+55 (00) 00000-0000'
    })

    this.salaryTarget.addEventListener('blur', () => {
      const salary = Number(this.salaryTarget.value)
      const oldSalary = Number(this.salaryTarget.getAttribute('data-proponent-id'))
        .toLocaleString('en', {
          minimumFractionDigits: 2,
          maximumFractionDigits: 2
        })
      if (+oldSalary !== salary) {
        this.calculateINSSDiscount(Number(salary))
      }
    })
  }

  async onCepChange () {
    const zipcode = this.zipcodeTarget.value
    if (zipcode.length === 9) {
      const param = zipcode.replace('-', '')
      try {
        const response = await fetch(`https://viacep.com.br/ws/${param}/json/`)
        const data = await response.json()
        if (!data.erro) {
          this.streetTarget.value = data.logradouro
          this.districtTarget.value = data.bairro
          this.cityTarget.value = data.localidade
          this.ufTarget.value = data.uf
        } else {
          this.streetTarget.value = ''
          this.districtTarget.value = ''
          this.cityTarget.value = ''
          this.ufTarget.value = ''
        }
      } catch (error) {
        console.error('Error fetching data:', error)
      }
    }
  }

  async calculateINSSDiscount (salary: number) {
    try {
      const response = await fetch(`/proponents/calculate_inss_discount?salary=${salary}`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json'
        }
      })
      const { inssDiscount } = await response.json()
      this.displayINSSDiscount(inssDiscount)
    } catch (error) {
      console.error('Error calculating INSS discount:', error)
    }
  }

  displayINSSDiscount (inssDiscount: number) {
    const discountElement = document.getElementById('discount-salary')
    discountElement.textContent = `Desconto INSS: R$ ${inssDiscount.toFixed(2)}`
  }
}
