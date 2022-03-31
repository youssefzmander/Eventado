const mongoose = require('mongoose')



const eventSchema = new mongoose.Schema({

    name: {
        type: String,
        required: true
    },
    date: {
        type: Date
    },
    Price: {
        type: Number
    },
    participants: [{ type: mongoose.Schema.ObjectId, ref: "User" }],
    description: {
        type: String
    },
    Affiche: {
        type: String
    },
    organizer:{
        type:String
    }
    

})

module.exports = mongoose.model('event', eventSchema)