import { RouterModule, Routes } from "@angular/router";
import { HomeAdminComponent } from "./home-admin/home-admin.component";
import { HomeLayoutComponent } from "./home-layout/home-layout.component";
import { HomeUserComponent } from "./home-user/home-user.component";
import { NgModule } from "@angular/core";



const routes: Routes = [

    {
        path: "",
        component: HomeLayoutComponent,
        children: [
            { path: "admin", component: HomeAdminComponent },
            { path: "user", component: HomeUserComponent }
        ]

    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})

export class HomeRoutingModule { }