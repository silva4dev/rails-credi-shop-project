import { Controller } from '@hotwired/stimulus'
import Chart from 'chart.js/auto'

type ChartDataProps = { [key: string]: { proponents: any[], total: number } }

export class ProponentChartController extends Controller {
  static values = { chartData: Object }

  chartDataValue: ChartDataProps

  connect () {
    const data = this.chartDataValue
    if (data) {
      const labels = Object.keys(data)
      const values = Object.values(data).map((item) => item.total)
      const ctx = (this.element as HTMLCanvasElement).getContext('2d')
      if (ctx) {
        new Chart(ctx, {
          type: 'doughnut',
          data: {
            labels: labels,
            datasets: [
              {
                label: 'Total de funcionários',
                data: values,
                backgroundColor: [
                  'rgba(255, 99, 132, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(255, 206, 86, 0.2)',
                  'rgba(75, 192, 192, 0.2)'
                ],
                borderColor: [
                  'rgba(255, 99, 132, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(255, 206, 86, 1)',
                  'rgba(75, 192, 192, 1)'
                ],
                borderWidth: 1
              }
            ]
          },
          options: {
            responsive: true,
            plugins: {
              legend: {
                position: 'bottom'
              }
            }
          }
        })
      }
    }
  }
}
