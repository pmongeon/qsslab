---
widget: slider
weight: 1
active: true
headless: true

design:
  # Slide height is automatic unless you force a specific height (e.g. '400px')
  slide_height: ''
  is_fullscreen: true
  # Automatically transition through slides?
  loop: false
  # Duration of transition between slides (in ms)
  interval: 2000

content:
  slides:
    - title: Welcome to the QSS Lab
      content: Named after the [Quantitative Science Studies (QSS)](https://www.mitpressjournals.org/qss) journal, the official **open access** journal of the [International Society for Scientometrics and Informetrics (ISSI)](http://www.issi-society.org/), the lab aims to advance knowledge on the production, dissemination and use of research.  
      align: center
      background:
        position: right
        color: '#666'
        brightness: 0.7
        media: 
    - title: QSS talks series 
      content: 'The QSS talks are informal research presentations by members of the labs and guests.'
      align: left
      background:
        position: center
        color: '#555'
        brightness: 0.7
        media: contact.jpg
	  link:
        icon: graduation-cap
        icon_pack: fas
        text: Join Us
        url: ../contact/
    - title: World-Class Semiconductor Lab
      content: 'Just opened last month!'
      align: right
      background:
        position: center
        color: '#333'
        brightness: 0.5
        media: welcome.jpg
      link:
        icon: graduation-cap
        icon_pack: fas
        text: Join Us
        url: ../contact/
---
