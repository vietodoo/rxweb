import { Component, OnInit } from '@angular/core';
import { FormGroup } from "@angular/forms"
import { HttpClient } from '@angular/common/http';

import { RxFormBuilder } from '@rxweb/reactive-form-validators';

import { User } from './user.model';

@Component({
    selector: 'app-odd-edit',
    templateUrl: './odd-edit.component.html'
})
export class OddEditComponent implements OnInit {

    userFormGroup: FormGroup

    constructor(
        private formBuilder: RxFormBuilder,		private http: HttpClient

    ) { }

    ngOnInit() {
        this.http.get('assets/examples/reactive-form-validators/decorators/odd/edit/user-data.json').subscribe(user => {
            this.userFormGroup = this.formBuilder.formGroup<User>(User,user);
        })
    }
}
