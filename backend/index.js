const express = require('express')
const cors = require('cors')
const fs = require('fs')
const app = express()

app.use(cors())

app.get('/api/groups/:groupId/next_event', (req, res) => {
  const eventFile = fs.readFileSync('../test/mocks/event.json')
  const eventData = JSON.parse(eventFile)
  res.send(eventData)
})

app.listen(8080, () => console.log('Server running at http://localhost:8080'))