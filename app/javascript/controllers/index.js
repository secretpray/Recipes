import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import TextareaAutogrow from "stimulus-textarea-autogrow"

const application = Application.start(document.documentElement)
const context = require.context('.', true, /_controller\.js$/)
application.load(definitionsFromContext(context))
application.register("textarea-autogrow", TextareaAutogrow)
