// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap'
import "toastr"
import "trix/dist/trix"
import "controllers"

// import "@fortawesome/fontawesome-free/css/all"
// import "../stylesheets/application"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("@rails/actiontext")
require("trix")
require("@rails/actiontext")
require("controllers")
require("utilities/popover")
require("utilities/auto_hide")
require("utilities/reviews")
require("utilities/add_reviews")
require("utilities/add_personal")
require("utilities/clear_date_form")
require("utilities/advanced_search")
require("utilities/rails-social-share-button")

global.toastr = require("toastr")
window.Rails = Rails
