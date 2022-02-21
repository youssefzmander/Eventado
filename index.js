const path = require("path");
const express = require('express')
const app = express()
const mongoose = require('mongoose')
require('dotenv').config();


mongoose.connect(process.env.DATABASE_URL, { useNewUrlParser: true, useUnifiedTopology: true })
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


app.listen(3001, () => console.log('Server Started'))