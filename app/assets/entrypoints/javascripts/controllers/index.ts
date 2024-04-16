import * as Turbo from "@hotwired/turbo";
import { application } from "./application";
import { ProponentFormController } from "./proponent_form_controller";

application.register("proponent-form", ProponentFormController);
Turbo.start();
