import * as Turbo from '@hotwired/turbo'
import { application } from './application'
import { ProponentsFormController } from './proponents_form_controller'

Turbo.start()
application.register('proponents-form', ProponentsFormController)
