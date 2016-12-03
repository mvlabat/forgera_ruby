import { Injectable } from "@angular/core";
import { Http, Response } from "@angular/http";
import { Mod } from "../models/mod";

import 'rxjs/add/operator/toPromise';

@Injectable()
export class ModService {
  private host = 'http://localhost:3001/';

  private get_url = this.host + 'mods';
  private post_url = this.host + 'mods';
  private update_url = this.host + 'update';

  constructor(private http: Http) {}

  getMods(): Promise<Mod[]> {
    return this.http.get(this.get_url)
      .toPromise()
      .then(response => response.json() as Mod[])
      .catch(ModService.handleError);
  }

  addMod(project_url: string): Promise<Mod> {
    return this.http.post(this.post_url, {project_url: project_url})
      .toPromise()
      .then(response => response.json() as Mod)
      .catch(ModService.handleError);
  }

  updateMods(): Promise<Mod[]> {
    return this.http.get(this.update_url)
      .toPromise()
      .then(response => response.json() as Mod[])
      .catch(ModService.handleError);
  }

  private static handleError(error: any): Promise<any> {
    if (error instanceof Response) {
      console.error('An error occured', error.text());
      return Promise.reject(error.text());
    }
    console.error('An error occured', error);
    return Promise.reject(error.message || error);
  }
}
