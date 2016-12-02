import { Component, OnInit } from "@angular/core";
import { ModService } from "../services/mod.service";
import { Mod } from "../models/mod";

@Component({
  selector: 'mods',
  templateUrl: 'public/mods.component.html'
})
export class ModsComponent implements OnInit {
  title = 'Mods';
  mods: Mod[];
  modUrl = 'https://minecraft.curseforge.com/projects/journeymap-32274';

  constructor(private modService: ModService) {}

  ngOnInit(): void {
    this.populateMods();
  }

  populateMods(): void {
    this.modService.getMods().then(mods => this.mods = mods)
  }

  addMod(): void {
    this.modService.addMod(this.modUrl).then(mod => this.mods.push(mod))
  }

  updateMods(): void {
    this.modService.updateMods().then(mods => this.mods = mods)
  }
}