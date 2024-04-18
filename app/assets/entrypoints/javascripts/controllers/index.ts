import * as Turbo from '@hotwired/turbo'
import { application } from './application'
import { ProponentFormController } from './proponent_form_controller'
import { ProponentChartController } from './proponent_chart_controller'

application.register('proponent-form', ProponentFormController)
application.register('proponent-chart', ProponentChartController)
Turbo.start()
