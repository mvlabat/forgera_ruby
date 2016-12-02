import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppRoutingModule } from './app-routing.module'

import { AppComponent } from "./components/app.component";
import { ModsComponent } from "./components/mods.component";
import { ModService } from "./services/mod.service";

@NgModule({
  imports: [
    BrowserModule,
    FormsModule,
    AppRoutingModule,
    HttpModule,
  ],
  declarations: [
    AppComponent,
    ModsComponent,
  ],
  providers: [ModService],
  bootstrap: [AppComponent],
})
export class AppModule {
}
