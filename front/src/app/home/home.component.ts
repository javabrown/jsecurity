import { Component} from '@angular/core';
import { AppService } from '../app.service';

@Component({
  templateUrl: './home.component.html'
})
export class HomeComponent {
  greeting = {};

  constructor(private app: AppService) {
    app.getResorces(data=> this.greeting = data);
  }

  authenticated() { return this.app.authenticated; }

}
