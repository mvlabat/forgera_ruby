[![Build Status](https://travis-ci.org/mvlabat/forgera_ruby.svg?branch=master)](https://travis-ci.org/mvlabat/forgera_ruby)

## Deploying backend
**Ruby version** the project was developed on: 2.3.3

**Database:** PostgreSQL<BR>
**Login:** forgera_ruby<BR>
**Password:** forgera_ruby

```bash
cd backend
bundle install
rails db:setup
rails s -p 3001 # if you want to change this, don't forget to fix it in the frontend, see below
```

### Testing
```bash
rspec # being in the backend directory
```

## Deploying frontend
Tools required: [Angular CLI](https://cli.angular.io/)
```bash
cd frontend # ../frontend, if you're currently in the backend directory
ng serve --prod
```
**If you've changed rails port (from 3001) or you're hosting backend not on your local machine**,
you have to change `host` field at `frontend/src/app/services/mod.service.ts`.

That's a temporary workaround.
I'm still looking for on how to pass command line arguments to the Angular app...
