mongoose = require 'mongoose'
Schema = mongoose.Schema
Slot = require './slot.coffee'

EventSchema = new Schema
	title: String
	start_date: Date
	venue: String
	slots: [Slot]

module.exports = mongoose.model 'Event', EventSchema
