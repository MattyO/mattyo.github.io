## My Response

I generally agree with the post. It comes off a little blamey without many practical recommendations. He is headed down a positive line of thinking, and in the end, we would mostly agree with him if we all sat down and had more extended, more nuanced conversations.



I generally don't enjoy short, aggressive blog posts.  It makes me feel tricked by the SEO algorithm and cheapens the post for me.

### Takeaways

I don't agree with the first two takeaways at all.

- You should choose to do a thing based on its merits or not.  The cost structure he mentioned earlier (it affects every sprint forever) will dwarf any amount you could charge.
- Tracking time, effort, and opportunity cost is a fool's errand.  It's always turns into navel-gazing monopoly money in the past for me

I do agree with his 3rd point.  But... If you are at the point where this is a new idea, I think this recommendation will be pretty unclear in how to do it. Even here in TD Slack, we all probably have different ideas about what observability and instrumentation mean.

## My response

### I love the original concept !

Weirdly, when I think about the original idea.

> Don't do custom features.  They aren't worth it because you overlook how they affect the whole system.  That system is not only the product but also the machine that your company makes.



I not only agree with it, but I would go further and suggest that **you should treat *every* feature with this kind of skepticism**, even the ones that are meant to be general! Many, if not most, organizations IMEs spend a pretty minimal, if any, effort in inspecting and quantifying the value of features they are building.  The average organization can't list the features that are in their current product or know what it does at that feature level. That is wild.

We should be this skeptical about whether a feature is useful or used not only at the time we write it, but we should be constantly re-evaluating features we wrote in the past.

And ya can go farther than that! Heck, we should be this introspective about how we spend our time as a whole!

Quick side note and detour: This also leads ya down a pretty fun rabbit hole of "what is really important to us.  Should we be spending time on things that increase profit? Ethics? Customer enjoyment? Future valuation?

### Lets talk about costs
It was mentioned by a few people, and there are features that no one uses but are regulated into the product or customers have to check a box that they can't remove. These are quantifiable, but the data is in a different place than the normal instrumentation and observability spots. They are in some sales documentation hole.  Remember how we should be being more introspective about our time. Go talk to your clients and sales people and dig through historical docs is a great use of time for everyone!

When thinking about cost, our author seems to treat the cost of removing a feature as free. Removing thing is just a different kind of refactoring and still takes time.

But I think there is a bigger, harder-to-quantify cost. I think (but I do not have any sources or resources to confirm this) that customers/users are a bit adverse to change in a few ways.

- It will break customer workflows or technical integrations. This will cost those customers real-time and $ in either technical work or re-jiggering workflows.
- Change injects future risk and concern and adds to today's stress.  If this product is undergoing a huge amount of change today, even if it doesn't affect me, will it still work for me in the future?  Should I invent even more integrations that could be a huge cost in the future if I have to totally replace it?
- Think about the following scenario.  You have a client that you would have evenutally won anyway, but now they are using a feature that should never have existed.  They would have found a different way to integrate if you didn't build it in the past, but that is not the world you live in today.  If you remove the feature, you might lose that company.  They won't find that other integration or workflow that still exists. They will just leave.

All of these are nearly impossible to measure.  You could do some funny stats that compare product change dates to churn rates to estimate these costs.  I would love to see someone do that.  I would love to find a UI person to do some analysis around the most cost effective way to make changes.  A big bang change where you have to re-learn a ton of stuff at once, or a constant stream of small changes.



## My Recommendations

### Make a leaky abstraction

 If you want a special calculation, I'll give you a metadata field, a webhook to let you know when an event is fired, and an API to let you update your special field.  That has a few really nice product outcomes.

- Particular clients get to own the risk of their own particularities.
- It is a different kind of version of making the most general feature.
- There is overlap with features you likely need anyway.  Webhooks, APIs, exporting/backing up/importing data, backups, and importing.

Note: Offer to build their integration for free. If you were going to build the feature for free anyway, why not?

### Be conciously Introspective

Set aside regular time to be more introspective as a company and do a quarterly or annual product review/overview.

A lean coffee session would be a great format.  Get everyone in the room (sales, engineering, leadership, product ppl) and talk about what your product currently does.  Brain storm what bits are weird, what seems not all that useful, how it has changed and what knock on effects those wider changes might have.

### Identify what your product really is

Build a living doc describing your product.  This is pretty useful in lots of different ways.

- a great introduction to new employees
- valuable context for quarterly planning
- useful for developers and technical teams to have this wider context.
- useful for user interface and user journey design
- useful for testing.

But you don't know what your application does today.  How do we start?

- open checkout your settings page
- Talk to your salespeople.  What do they show people in a demo?
- What regulations do you meet?
- Whitebox datadog analysis. Install tracing. What controllers are hit the most?  What do they do? Be careful with code paths != features.
- Re-read your marketing site.
