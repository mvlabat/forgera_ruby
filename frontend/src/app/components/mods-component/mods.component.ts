import { Component, OnInit } from "@angular/core";
import { ModService } from "../../services/mod.service";
import { Mod } from "../../models/mod";

@Component({
  selector: 'mods',
  // moduleId: module.id,
  templateUrl: 'mods.component.html',
})
export class ModsComponent implements OnInit {
  title = 'Mods';
  mods: Mod[];
  modUrl = 'https://minecraft.curseforge.com/projects/journeymap-32274';
  isWaiting = false;
  errors: string[];

  constructor(private modService: ModService) {}

  ngOnInit(): void {
    this.populateMods();
  }

  populateMods(): void {
    this.beginAction();

    this.modService.getMods().then(mods => {
      this.mods = mods;
      this.isWaiting = false;
    }).catch(error => this.catchError(error));
  }

  addMod(): void {
    this.beginAction();

    this.modService.addMod(this.modUrl).then(mod => {
      this.mods.push(mod);
      this.isWaiting = false;
    }).catch(error => this.catchError(error));
  }

  updateMods(): void {
    this.beginAction();

    this.modService.updateMods().then(mods => {
      this.mods = mods;
      this.isWaiting = false;
    }).catch(error => this.catchError(error));
  }

  beginAction(): void {
    this.isWaiting = true;
    this.errors = [];
  }

  catchError(error: any): void {
    this.errors.push(error);
    this.isWaiting = false;
  }

  dismissError(index: number): void {
    this.errors.splice(index, 1);
  }
}
