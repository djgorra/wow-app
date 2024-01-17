
# RaidCraft - Admin

RaidCraft is an application to coordinate loot drops in Classic World of Warcraft. Log in and add your friends' Battletags. Create your WoW characters and their wishlists -- then when you're ready, schedule a run. You'll be able to mark who received which drop and which drops are disenchanted.

The application has two components - The phone application written in React Native, and the server backend written in Ruby on Rails.

[Click here for the React Native application.](https://github.com/djgorra/reactwowapp)

The Ruby on Rails server acts as a backend and allows admins to browse teams and characters.


## Authors

- [DJ Gorra](https://www.github.com/djgorra)
- [Nicole Beguesse](https://github.com/perryb)


## Installation

Run the server with:

```bash
  bundle install
  rails server
```

If no AdminUser exists, create one with:

```bash
    bundle exec rails db:migrate
    bundle exec rails db:seed
```

Then you can login as the default user:
- User: admin@example.com
- Password: password

Fill the database with data and icons:

```bash
    Item.seed
    Boss.seed
    Buff.seed
    CharacterClass.seed
    Raid.seed
    Spell.seed
```

For test accounts and sample data:
```bash
    User.seed
```
    
## Screenshots

![App Screenshot](https://wow-app-rails-5c78013cc11c.herokuapp.com/screenshots/admin_login.png)



## REST API Reference

| Parameter | Description                |
| :-------- | :------------------------- |
| `/api/users/sign_in`   | Log in with email and password to get a bearer token  |
| `/api/data_file`| Retrieve a list of all classes, specs, races, genders, raids and bosses|
| `/api/friendlist` | Add or remove friends |
| `/api/characters` | Add, edit or remove WoW characters |
| `/api/characters/${character_id}/items` | Add or edit wishlist items |
| `/api/teams` | Add or edit teams of characters |
| `/api/teams/${team_id}/runs/${run_id}` | Create or retrieve a run for a team |
| `/api/battles` | Create a battle for a run|
| `/api/battles/${battle_id}/drops` | Create or edit a drop for a battle|

## License

[GPL](https://www.gnu.org/licenses/gpl-3.0.en.html)





