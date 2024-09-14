import { CommonModule } from "@angular/common";
import { HttpClientModule } from "@angular/common/http";
import { NgModule } from "@angular/core";
import { HomeRoutingModule } from "./homeRoutingModule";




@NgModule({

    imports: [CommonModule, HttpClientModule, HomeRoutingModule ],
    declarations: [

    ]

})

export class HomeModule { }