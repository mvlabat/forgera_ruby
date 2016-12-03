import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ModsComponent } from "./components/mods-component/mods.component";

const routes: Routes = [
  { path: '',  component: ModsComponent },
];
@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {}
