<template>
  <div class="toilet-wrapper">
    <img src="../assets/Paper.png">
    <p class="description">
      {{ on ? 'Available' : 'Occupied' }} for {{ uptime }},<br/>
      became <strong>{{ on ? 'Occupied' : 'Available' }}</strong><br/>
      {{ fromNow }}.
    </p>
    <div class="led-box">
      <div class="led" :class="on ? 'led-red' : 'led-green'"></div>
    </div>
  </div>
</template>

<script>
import mqtt from 'mqtt'
import moment from 'moment'

export default {
  computed: {
    count () {
      return this.$store.state.count
    }
  },
  data () {
    return {
      on: false,
      updatedAt: null,
      uptime: 'N/A',
      fromNow: 'N/A'
    }
  },
  created () {
    this.updatedAt = new Date()

    setInterval(() => {
      this.fromNow = moment(this.updatedAt).fromNow()
      client.publish('cmnd/sonoff-sensor/status', '8')
    }, 500)

    const client = mqtt.connect('mqtt://192.168.1.20:9090')
    const topicStatus = 'stat/sonoff-sensor/STATUS'

    client.on('connect', () => {
      client.subscribe(topicStatus)
    })

    client.on('message', (topic, message) => {
      const state = (JSON.parse(message.toString()).Status.Power === 1)
      if (this.on !== state) {
        this.on = state
        this.uptime = moment(this.updatedAt).fromNow(true)
        this.updatedAt = new Date()
      }
    })
  }
}

</script>

<style>

.toilet-wrapper {
  position: absolute;
  left: 50%;
  top: 50%;
  width: 450px;
  height: 450px;
  transform: translate(-50%, -50%);
  background-color: rgba(255, 255, 255, 0.93);
  box-shadow: 0 5px 10px 0 rgba(0,0,0,0.20);
  border-radius: 5px;
  text-align: center;
}

.toilet-wrapper img {
  padding-top: 50px;
  width: 120px;
  height: 120px;
}

.toilet-wrapper .description {
  margin: 30px auto 30px;
  font-size: 28px;
  color: #9b9b9b;
  font-weight: 200;
}

.toilet-wrapper .description strong {
  font-weight: bold;
  color: #000;
}

.led-box {
  height: 30px;
  width: 25%;
  margin: 10px auto;
}

.led-box p {
  font-size: 12px;
  text-align: center;
  margin: 1em;
}

.led {
  margin: 0 auto;
  width: 56px;
  height: 56px;
  border-radius: 50%;
}

.led-red {
  background-image: linear-gradient(-180deg, #F5515F 0%, #9F031B 100%);
  box-shadow: 0 0 10px 0 #D0011B, inset 0 3px 10px 0 rgba(0,0,0,0.26);
}

.led-green {
  background-image: linear-gradient(-180deg, #B4ED50 0%, #429321 100%);
  box-shadow: 0 0 10px 0 #7ED321, inset 0 3px 10px 0 rgba(0,0,0,0.26);
}

</style>
