const mongoose = require('mongoose')



const eventSchema = new mongoose.Schema({

    name: {
        type: String,
        required: true
    },
    date: {
        type: Date
    },
    time: {
        type: String
    },
    participants: [{ type: mongoose.Schema.ObjectId, ref: "User" }],
    description: {
        type: String
    },
    Affiche: {
        type: String
    }

})

module.exports = mongoose.model('event', eventSchema)