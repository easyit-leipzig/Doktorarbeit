import matplotlib.pyplot as plt
import matplotlib.animation as animation
from matplotlib.patches import Rectangle, Circle

# Parameter
room_length = 10
room_height = 4
observer_x = 2
observer_y = 2
ball_x = 5
ball_y = 2

# Initialisierung der Figur
fig, ax = plt.subplots(figsize=(10, 4))
ax.set_xlim(0, 15)
ax.set_ylim(0, 6)
ax.set_aspect('equal')
ax.axis('off')

# Raum, Beobachter und Ball als Objekte
room = Rectangle((1, 1), room_length, room_height, fill=False, linewidth=2)
observer = Circle((observer_x, observer_y), 0.3, color='black')
ball = Circle((ball_x, ball_y), 0.2, color='gray')

# Hinzufügen zur Zeichnung
ax.add_patch(room)
ax.add_patch(observer)
ax.add_patch(ball)

# Bewegung des Raums simulieren (Gleichförmige Bewegung)
def init():
    room.set_xy((1, 1))
    observer.center = (observer_x, observer_y)
    ball.center = (ball_x, ball_y)
    return room, observer, ball

def animate(i):
    dx = 0.03 * i
    room.set_xy((1 + dx, 1))
    observer.center = (observer_x + dx, observer_y)
    ball.center = (ball_x + dx, ball_y)
    return room, observer, ball

ani = animation.FuncAnimation(fig, animate, init_func=init, frames=150, interval=50, blit=True)
