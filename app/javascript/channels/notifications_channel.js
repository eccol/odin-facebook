import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
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
