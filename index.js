const path = require("path");
const express = require('express')
const app = express()
const mongoose = require('mongoose')
require('dotenv').config();


mongoose.connect("mongodb+srv://mej:123test@cluster0.we743.mongodb.net/eventado?retryWrites=true&w=majority", { useNewUrlParser: true, useUnifiedTopology: true })
const db = mongoose.connection
db.on('error', (error) => console.error(error))
db.once('open', () => console.log('Connected to Database'))

app.use(express.json())

app.use(express.urlencoded({ extended: false }));

app.use('/images', express.static(path.join(__dirname, 'images')));
//routes
const userRouter = require('./routes/user')
app.use('/user', userRouter)

const EventRouter = require('./routes/event')
app.use('/event', EventRouter)


const EventRegisterRouter = require('./routes/eventRegister')
app.use('/eventRegister', EventRegisterRouter)


app.listen(3001, () => console.log('Server Started'))