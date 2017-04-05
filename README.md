### Anychat - Your private communication

You can use service at [https://anychat.4me.tips](https://anychat.4me.tips) or take and server, install it yourself then share to your partners.

* Basic Authentication username/password: guest/anychat (Will be removed in major version)


### Background

* You meet a guy that you want to talk to, but you don't want give him your phone.
* You get some questions from stranger, you want to answer but don't want to let him knows your FB messenger/email account.

So you need a chatting method that:

* **No** installed app required.
* **No** email, phone or any social account required.
* **No** session or anything saved after you close browser.
* **No** one knows who you are.

### Some special points
* Other guys **CANNOT** see anything about your profile exclude your username.
* Easy to share your username to other by QR Code
* The first and only first message from other guy will be sent to you when you offline via email, if you setup in profile.

### Stacks
* Nginx
* Puma
* Rails 5.0.2 with ActionCable
* Redis
* MySQL (To store username/password only. If you install it yourself and not much number users, you can replace by SQLite)

### Install and deploy your self

* Run `$cd /path/to/project/ && cp .env.example .env` in your local machine.
* Fill all required information in .env file
* Run `$bundle install` in your local machine.
* Define your server, git repo in `/path/to/project/config/deploy/staging.rb`
* Run `$cap staging deploy:init` from your local machine for first deployment
* Run `$cap staging deploy` from your local machine for next deployments

### Development

All pull requests, issues, stars are welcome!

### License

MIT.


