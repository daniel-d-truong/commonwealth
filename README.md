## Inspiration
Forests are torn down to make our paper. Producing a single battery demands nearly 9000 liters of water. Buying medical masks can leave doctors without proper protective equipment. As the world moves forward into the perils of COVID-19 pandemic and moreso, global warming, our individual spending decisions account for the health of our whole community and the globe. The supermarket is the battleground. This concept inspired our team to engineer an app that helps users avoid the social and environmental costs that hide behind every purchase and, in turn, protect the commonwealth of humanity.

![Logo](https://camo.githubusercontent.com/836e399c9123f314183ba1b1f8b342fe982cd120/68747470733a2f2f64726976652e676f6f676c652e636f6d2f75633f69643d315062462d686e785a6d446956727835302d6f634854554757433855346e396873)

## What it does
We are **Commonwealth**. Commonwealth alerts the average consumer of the environmental and social footprint of their purchases to promote responsible eco-friendly spending _and_ resist against the spread of COVID-19. Commonwealth employs years of real world data to analyze and accurately calculate the costs of a single purchase on your community and the Earth. Users can easily add items to their shopping cart through our Item Selection tab to be informed of their cost. If they're in a rush, they can pull out their phone and scan items in real time using our TensorFlow object detection software and the individual items are assigned a cost.

## How we built it

We developed an iOS mobile application using Swift to create our logic and interfaces. We utilized GCP's ML Kit (Tensorflow Lite) to create the real-time scanning of items using the phone's camera. We also used the Google Map's API for location tracking.

While the final output is a simple price tag, Commonwealth is built on a wide variety of data. Here are some of the different measures and datasets that were used to create our unique scoring function. 

#### WATER FOOTPRINT
While 75% of the world is made up of it, there is only so much of it that humans can use. Water is the key to producing a great deal of industrial products. The [Water Footprint Network](https://waterfootprint.org/en/resources/waterstat/) maintains a comprehensive database of how many liters of water it takes to produce just about any animal product, crop, and industrial item. This data is cognizant of the differences in production footprint in different parts of the globe. However, as we needed a single, more universal measurement, we used [Pandas](https://pandas.pydata.org/) to aggregate this tabular data into a weighted global average (L) for every individual item. This final number of liters is added to the cost according the US government's utility rate for tap water.

#### DROUGHTS AND FOOD DESERTS
Not all cities are made equal. While some cities like Portland, OR and Atlanta, GA. are surrounded by fertile land for agriculture, desert cities like Phoenix and Las Vegas are not as lucky. As such, markets in these cities often get their fruits and other goods from distant agricultural area. The transportation of these goods from across the nation leaves a rough financial impact. We account for this by adding to the uCost based on the number of droughts that the users county experiences and other current data from the [United States Drought Monitor](https://droughtmonitor.unl.edu/). This data helps us ascertain whether the user is in a food desert or a more self-sufficient city.

#### MEDICAL DEMAND
Who really needs the rubber gloves? Medical professionals across America have come into trouble acquiring PPE (personal protective equipment) such as goggles, gowns, gloves, and — [most importantly](https://chicago.suntimes.com/coronavirus/2020/4/24/21233524/face-masks-coronavirus-consumer-guide) — face masks. One of the ways we can help our doctors and nurses is by not exhausting the supply of PPE. As such, all medical items come with an according social tax based on how much medical personnel need them.

#### PUBLIC DEMAND
While some items are still plentiful even during quarantine, [others](https://sellics.com/blog-coronavirus-covid-amazon-online-shopping/?fbclid=IwAR0Zc6r5cCJo1q8BwZvHhLDrGJcSMW6Zu8OpOkAWMAGJU4IlqmB0chsJg1A) due to their perceived longevity in a crisis. As such, non-perishables like rice and pasta are some of the first to leave shelves in a crisis. This is problematic as these items are some of the limited options that SNAP EBT(food stamp) users can purchase, leading to great stress on [state funding](https://www.wifr.com/content/news/Illinois-to-distribute-an-additional-112-million-to-SNAP-recipients-with-children-across-the-state-569802551.html). As such, to alert users of the costs that buying these items in bulk has on the community, we add an additional social tax. We used the aforementioned Amazon data to determine demand for these items categorically (Health, Household, Electronics, etc) and determined their supply as an inverse of this demand. 

#### LOCATION
In the age of COVID-19, it is important that we remember the two 3s. An infected person can go up to _three_ weeks without noticing their symptoms and still being viral. Secondly, the virus can live on surfaces for up to _three_ days. We used the number of Coronavirus cases by county scaled to the population to measure the risk of spreading the disease that one causes by going to a store and coming in contact with uncleaned surfaces and perhaps other people. This risk coefficient is multiplied with the precalculated cCost to generate the final price. This coefficient was generated through MinMax Scaling using [sklearn](https://scikit-learn.org/stable/)


![Equation](https://drive.google.com/uc?id=13KWYdy3ac3Wuol0sEwvnk6pvLc7GTQb1)
**Our Design!**


## Challenges we ran into
While we worked with a vast array of datasets and endless entries in each one, we managed to narrow that data down to two final .csv files. This was of course possible due to the tabular data processing possible on pandas. One of the problems we faced was the joining of two tables regarding Coronavirus case data by county and county population respectively. This was hard to join because the two tables had many inconsistencies about the names of counties and the spellings (including or discluding hyphens, etc). Additionally, there were numerous errors such as miscellaneous characters like .!~* appeaing before the names of counties at random. This cleaning process took a great deal of time and slowed down our processes a lot. 
![scikitlearn](https://drive.google.com/uc?id=1MtlQ5pQa1HskT2UoFwZG7htxns8DlMlW)
**Using sk-learn and pandas helped us immensely with preprocessing.**

## Accomplishments that we're proud of
A great deal of data analysis and calculated fields are created by academia to measure different phenomenon every year. However, without proper visuals and interactivity to present that data, a lot can get lost in between the lines. That is why we made a special effort to make the Commonwealth app with bright, material, and easily navigable design. We're especially proud of the use of TensorFlow to automatically detect objects in the camera mode. However, overcoming the difficulty of properly implementing our design and wrangling the underlying data and algorithms together all in one night is definitely the accomplishment we're proudest of. 

![swift](https://drive.google.com/uc?id=1uDRo0bVYe1NHyAwGqlX_nBF01c-kkuGk)
**Using this data, we created a mobile interface on iOS.**

## What we learned
Commonwealth is a simple platform built on a myriad of different technologies.

We were able to collaborate and manifest this creative vision through the real-time interface design tool, Figma. This allowed us the export our ideal design to Swift for Storyboarding. The immense data wrangling process was mostly carried out in Python and used pandas and numpy to integrate different datasets and clean their content. sklearn libraries were used to scale datasets with wide spreads and decrease the variance of certain figure. To expedite the addition of items to the user's shopping cart, we used a TensorFlow Lite mobile-optimized classifier. This was our first intro to transfer learning. Furthermore, we all learned a great deal about the various impacts that the simplest purchases can have on our world.
 
## What's next for Commonwealth
Commonwealth's systems are built specific to American coronavirus data and a broad global average for water footprints. However, the underlying concept transcends the USD and American borders. Climate change and coronavirus are both deeply global issues and the effects will disproportionately affect those in the developing world. A further venture could move to localize Commonwealth for different markets.
