# Technology and Concept Analysis - Continuous Integration

With the key goals of improving software quality by finding and addressing bugs quicker as well as reducing time to validate and release new features, having an appropriate tool for Continuous Integration is vital for any application. Continuous Integration or CI is a practice that deals with verifying each code check-in through automated builds, allowing problems to be detected early and reduce risk. This document details the criteria the team designated important in deciding on the tool used for CI, and an analysis of each option in terms of said criteria.

## Criteria

While choosing a CI tool and service some chief criteria needed to be taken into consideration, in addition to the universal criteria. The following are what the team decided are the most important criteria needed to make the decision.

- **Time to deploy** - In order for the integration to be successful the proposed tool needs to be both easy to set up with the builds and not cause a delay in production.
- **Integration** - Since having continuous automated builds needs to be seamless, the tool needs to be well integrated with both GitLab and any languages used in the project.

## Pugh Matrix

| Criteria       | Weight | Jenkins | GitLab CI | Travis |
| -------------- |:-------|:--------|:----------|:-------|
| Ease of use    | 3      | 2       | 4         | 3      |
| Cost           | 4      | 5       | 5         | 5      |
| Time to deploy | 4      | 3       | 4         | 3      |
| Familiarity    | 2      | 3       | 3         | 3      |
| Integration    | 3      | 4       | 5         | 1      |
| Total          |        | **56**  | **69**    | **50** |

## Options

There are several available CI tools, each having a set of advantages and disadvantages. The choices were narrowed down to three most pertinent to the project and team. A detailed description of each option and how they meet (or don't meet) each criteria follows.

- **Jenkins** - The first option considered by the team was using a popular open-source, cross-platform tool that offers configuration both through GUI interface and console commands.
    - **Ease-of-use** - Rating: 2 - Although both powerful and flexible Jenkins is known to have a steep learning curve and take time to manage and configure. For this reason the rating for ease of use is low, since more time than necessary will be spent learning to use it.
    - **Cost** - Rating: 5 - Jenkins is an entirely free, open-source tool that offers several free plugins as well.
    - **Time to deploy** - Rating: 3 - As briefly stated in ease-of-use, although the actual builds may be fast, it would take time to configure and manage them.
    - **Familiarity** - Rating: 3 - Although having a high learning curve, some of the team members have had brief interactions with the software before.
    - **Integration** - Rating: 4 - Being extremely flexible, Jenkins either supports or has plugins to support any software or language, as well as specific support with GitLab itself.

- **GitLab CI** - The second option considered by the team was using the CI tool offered by the teams currently used GitLab repository management software.
    - **Ease-of-use** - Rating: 4 - Considering it would be directly integrated with the software the team is currently using, it would add the benefit of having all resources in one place. Additionally, the appears to require less of a learning curve and provides only the essential and minimal configuration.
    - **Cost** - Rating: 5 - Although an Enterprise Version is available all of the necessary features are offered for free.
    - **Time to deploy** - Rating: 4 - Especially given that it is integrated in the teams current software, adding and setting it up would be seamless and simple.
    - **Familiarity** - Rating: 3 - Even though our team is using the GitLab services already, there are no team members familiar with the CI tools offered.
    - **Integration** - Rating: 5 - As mentioned above the tools will perfectly integrate with our currently used software. Additionally it has a wide range of support for any languages that we intend to use.

- **Travis** - The third option considered by the team was using another popular tool that has been around for longer than most CI tools.
    - **Ease-of-use** - Rating: 3 - Although not as complex as Jenkins, Travis also seems to require a bit of a learning curve and a significant amount of additional manageability.
    - **Cost** - Rating: 5 - Similarly to Jenkins the tool is entirely free and open-source.
    - **Time to deploy** - Rating: 3 - Building and managing would be more time consuming, since the integration with GitLab would have to involve a third party.
    - **Familiarity** - Rating: 3 - As the previously mentioned option no team members have ever extensively used the tool.
    - **Integration** - Rating: 1 - As mentioned above it would be difficult to integrate the tool with GitLab, since it was meant to only be used with GitHub.

## Conclusion

Given the ratings in the above criteria the team has come to a decision that the most useful CI tool or software for out project and team would be GitLab CI. The reasoning behind this is the seamless integration with our currently used GitLab software, which will vastly increase the ease-of-use and manageability. Additionally having all resources in one place reduced overhead and increases visibility and clarity. Although the other options provide more features and flexibility, the amount provided with GitLab CI is sufficient enough for the project and teams needs.