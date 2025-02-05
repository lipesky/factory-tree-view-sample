# Factory Tree View Sample
Demonstration app created with flutter meeting the instructions present in https://github.com/tractian/challenges/tree/main/mobile

https://github.com/user-attachments/assets/d86dab1d-6d15-4f51-b37b-c0312b4dcd90


### Layout
![flutter_challenge_v2](https://github.com/user-attachments/assets/6aca6ec1-dcc9-42a4-a1eb-3db37576cd7a)
[Figma Link](https://www.figma.com/design/IP50SSLkagXsUNWiZj0PjP/%5BCareers%5D-Flutter-Challenge-v2?node-id=0-1&p=f&t=kNfFbFujk9UKYBDu-0)

### File structure
In this repository, there are two main folders: 
- app
- sample_design_system
'app' folder contains the app main code, which should be installed on phone.
'sample_design_system' folder contains the app components app uses(like TreeView and FilterButton), and its required classes, datamodels...
 
This structure was choosen because it makes easier to re-use components between apps, divide responsabilities between teams and team members and favors code abstraction.

### TreeView Component
This is the most featured app widget. In this app, the approach to show company assets/locations is:
1 - Fetch json data from api.
2 - Parse json to model in a separate isolate to avoid freeze ui isolate 
3 - Generate TreeView data structure from models, keeping references to applying filters, in separate isolate to avoid freeze ui isolate (it is the most heavy computation in app)
4 - Pass to TreeView component for rendering.

### Tests
As it is a demo project, was choosen to only implement widget test for TreeView component(the app's main feature).

### Possible improvements
In a more detailed project or with more time, would be better to implement tests for all components in sample_design_system package, separate api communications, services, DTOs in another package, 
maybe models in another, more tests in each package. 
