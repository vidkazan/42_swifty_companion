# 42_swifty_companion
IOS app for searching Ecole 42 users and showing user profile

## Overview
<div align=center>
  <img src="https://github.com/vidkazan/42_swifty_companion/assets/33557107/3a5ed24b-f9ab-43fc-92ff-7775a417bf43" width=300>
</div>

<h2>State diagram</h2>
<img width="794" src="https://github.com/vidkazan/42_swifty_companion/assets/33557107/a0cf726f-2e2d-4b1e-9fc2-079923c795be">
<h2>Network layer</h2>

#### Problem
- 42 API request rate is 2 requests per second
- user search request is sending instantly after each update of the search field
- user typing speed can be faster than one symbol per 100ms
- all above may cause multiple 429 errors from API instead of data

#### Solution
- a special FIFO queue is used for API call tasks
- tasks are extracted from the queue one-by-one with a 500ms delay in a custom serial queue and executed in main concurrent queue
- optimizing and filtering API calls:
  - outdated tasks are canceled after being sent to prevent unnecessary view updates
  - outdated tasks are dropped from the deque before sending if a similar new task exists in the deque. This reduces the delay of receiving data
  
<img src="https://github.com/vidkazan/42_swifty_companion/assets/33557107/9067abd9-2c13-49c5-9572-7932d7b1dcd9" width=300>
<img src="https://github.com/vidkazan/42_swifty_companion/assets/33557107/744b46c2-d3ff-405e-87a8-710163e99d75" width=640>
