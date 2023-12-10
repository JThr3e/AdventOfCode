import torch

time = torch.tensor([52947594])
record = torch.tensor([426137412791216])

time_r = time.reshape(time.size()[0],1)
time_r = time_r.expand(time.size()[0],time.max())
rec_r = record.reshape(time.size()[0],1)
rec_r = rec_r.expand(time.size()[0],time.max())

button_hold = torch.arange(time.max()).repeat(time.size()[0],1)
mask = torch.ones_like(button_hold)
mask[button_hold > time_r] = 0
remaining_time = torch.sub(time_r, button_hold)
distance = torch.mul(button_hold, remaining_time)
win = distance > rec_r
win_mask = torch.mul(win, mask)
win = torch.sum(win_mask, 1)
score = torch.prod(win)
print(win)
