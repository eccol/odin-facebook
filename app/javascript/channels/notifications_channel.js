import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    console.log("Connected to NotificationsChannel")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    this.appendLine(data)
  },

  appendLine(data) {
    const html = this.createLine(data)
    const element = document.querySelector('.notifications')
    element.insertAdjacentHTML("beforeend", html)
  },

  createLine(data) {
    return `
    <div class="notification">
    ${data[body]}
    </div>
    `
  }
});
