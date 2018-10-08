import {
    ValidatorFn,AbstractControl
} from "@angular/forms";
import { DigitConfig } from "../models/config/digit-config";
import { digitValidator  } from '../reactive-form-validators/index'
import { defaultContainer } from "../core/defaultContainer"
import { AnnotationTypes } from "../core/validator.static"
import {STRING } from '../const/validator.const';

export function digitValidatorExtension(config?: DigitConfig): ValidatorFn {
    var validator = digitValidator(config);
    var rxwebValidator = (control:any,target?:object): { [key: string]: any } => {
        if (typeof control == STRING)
          defaultContainer.init(target, 0, control, AnnotationTypes.digit, config);
        else
          return validator(control);
      return null
    }
    return rxwebValidator;
}