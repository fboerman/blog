---
title: 'Using my new datalake in practise: a case study'
date: 2026-01-08
description: 'I am opening up my datalake as a commercial offering. This post shows a case study on how it can be used for analysis. Specifically this post looks at a specific CNEC which became more often an active constraint in the last quarter of 2025'
plotly: true
---
I have received many requests over the years for people wanting to use my private databases. I have always wanted to open it up but, until recently, never got around to setting up proper security and organisation. Now I have and my new Amun Analytics Datalake is [live in beta mode](https://ui.dl.amunanalytics.eu/)!  
You can register and login through the new Amun Single Sign On. After this you need to contact me through email or linkedin chat to ask to activate your account (this is still a manual action for now). 

You can already checkout the table catalog while you are waiting. Usage will be free while in beta mode, but I am planning on making this a commercial venture, with a reasonable monthly fee. The fee will be per company which then allows in principle unlimited usage (I will enforce a fair use policy at the start to not blow up my server though). If you are interested in buying such a service, and/or have ideas for other datasets to include, I would love to hear from you at [frank@amunanalytics.eu](mailto:frank@amunanalytics.eu)!  

Please note that my datalake is a product of **convenience**. There is <u>only public data</u> and some calculations using public data in it. Requests for confidential information will get you banned from my service forever.

# How to use the datalake
After activation you can download ready to go python or R code to help you get started. This code includes a way to retrieve an Oauth access token and how to then query the datalake with SQL through the Trino query engine.  
There are 2 ways to use the datalake. Since the datalake is build on Apache Iceberg, you can directly query the Iceberg REST catalog at [https://keeper.dl.amunanalytics.eu/catalog/](https://keeper.dl.amunanalytics.eu/catalog/), this uses Oauth JWT authentication. This allows you to use for example the pyiceberg package.  
The second, and easier method, is to use SQL to query the datalake. This also uses Oauth JWT authentication and is the method used in the example code. This allows you to directly query the datalake and filter/calculate the data you need. Currently you need to query through a Trino connection but in the future I am planning to also support a postgres connection.  
If some or all of these terms are unknown to you, simply checkout the ready to go example code from the webpage or follow the instructions below the case study in this post. This should help you to get started using the datalake. If you are stuck feel free to contact me at [frank@amunanalytics.eu](mailto:frank@amunanalytics.eu) or linkedin chat!

Further technical architecture is provided at the end of this post. But first lets go through a case study!

# The case study
Below text will go through the case study and show the sql queries. If you want to follow along with live code first read the "Running the code" part of the post below.  

Recently I got a question about a specific CNEC which showed up much more in the active constraints overview. (If you don't know what a CNEC or active constraints is in Flowbased read [this post](https://boerman.dev/posts/flowbased/whatis/cnecs_and_activeconstraints/) first). The question is, is this because of a network change or a market change?  
So the specific case here is that in my [daily reports](https://reports.coreflowbased.eu/members/) the CNE of "Altheim - Sittling 219" with Contingency "Altheim - Sittling 220" showed up more. This is an internal CNEC from TenneT Germany. So lets pull up all occurences of that CNEC being an active constraint for the last 4 months of 2024. This is done with query 1 below.
<figure class="center" style="width:100%">
<pre>
select * from flowbased_dayahead.active_constraints
where cne_eic = '11TD2L000000003L'
and cont_name = 'N-1 Altheim - Sittling 220'
and business_day >= '2025-08-01'
and business_day < '2025-12-31 23:59'
</pre>
<figcaption class="center">Query 1: Gather all occurences of specific CNEC for the last 4 months of 2024 in the Core Final Domain</figcaption>
</figure>
This pulls in all columns so we can scroll through it. You don't always need all columns, it is then advisable to list the ones you need.
 
Now lets see if there can indeed be seen an increasing trend. In order to do this lets plot the average shadow price and number of occurences in figure 1 below.

{{< plotly json="fig_shadow_prices.json" height="500px" caption="Figure 1: Average shadow price and number of MTU's over time" >}}

We can indeed see here an increasing trend of occurences and also an uptick in average shadow price from september onwards, compared to August. To answer the question if this can be caused by a network change we can check the two important indicators in the domain: RAM and PTDFs. Are there any specific changes in those?

First we gather the data from the final domain for this specific CNEC. This is done with query 2 below. As an example we use a different column to filter here then in the active constraints table.
<figure class="center" style="width:100%">
<pre>
select *
from flowbased_dayahead.final_domain
where cne_name = 'Altheim - Sittling 219'
and cont_name = 'Altheim - Sittling 220'
and business_day >= '2025-08-01'
and business_day < '2025-12-31 23:59'
</pre>
<figcaption class="center">Query 2: Gather all occurences of specific CNEC for the last 4 months of 2024 in the Core Final Domain</figcaption>
</figure>

First we calculate the worst case RAM per MTU (remember, each CNEC always has 2 entries per MTU, one for each direction!) and then we average this per business day. This results in figure 2 below.

{{< plotly json="fig_ram.json" height="400px" caption="Figure 2: Average worst case RAM over time" >}}

For this indicator lower RAM would signal network causes, as a downward trend would point to less capacity available on this CNEC. It seems this indicator becomes more volatile, but not necessarily much lower over time. I would call this fairly stable in flowbased terms.
 
Lets move on to the PTDFs. To get a single indicator we can look at the largest maximum zone to zone PTDF per MTU and average this per business day. This results in figure 3 below.

{{< plotly json="fig_z2z.json" height="400px" caption="Figure 3: Average worst case max Zone to Zone PTDF over time" >}}

For this indicator, higher max Z2Z PTDF would signal network causes, as it points to this CNEC being much more sensitive. Again this shows a relative volatile picture, but not a clear increasing trend that the constraint has become much more sensitive.

The combination of these indicators shows that it is unlikely that changes in the flowbased domain have caused the uptick in active constraint occurence for this CNEC. This leaves market fundamentals. Gábor Szatmári of Montel [published a linkedin post](https://www.linkedin.com/posts/g%C3%A1bor-szatm%C3%A1ri-0775a044_hu-deat-hu-spread-in-q4-activity-7407448570364313600-4q4h?utm_source=share&utm_medium=member_desktop&rcm=ACoAACc-79sB2aDopScZHfFvJ6YScRgJY8SAZWU) that showed the most likely answer. A strong change in market fundamentals drove a change in market direction. This then results in a shift in which active constraints show up!

This simple case study shows how you can quickly pull together some filtered data and check some basic indicators from the flowbased data. This enables you to quickly analyse Flowbased, which can help with understanding of, and working with, Flowbased market coupling.

If you want to try it out, move over to [https://ui.dl.amunanalytics.eu/](https://ui.dl.amunanalytics.eu/), register an account and [contact me](mailto:frank@amunanalytics.eu) for activation. If you are interested in getting a license for this to use it after the trail period, and/or have ideas on more datasets to include, contact me at [frank@amunanalytics.eu](mailto:frank@amunanalytics.eu)!

# Running the code for the case study
The code for this example case study is published in a notebook in [this github repo](https://github.com/fboerman/blog-notebooks). To easily run it yourself do the following, completely for free:
1. Go to [https://colab.research.google.com/](https://colab.research.google.com/) and login with your google account. If you dont have one, register one for free
1. After logging in it should show the "open notebook" menu. If not go to file -> open notebook
1. Click "GitHub" on the left, paste in the repo url from above and press enter
1. After waiting a bit you should see an entry with "20260107_high_active_constraint.ipynb", click this
1. Now copy your username and token either from the example python code from the main site, or go to [https://ui.dl.amunanalytics.eu/getkey/](https://ui.dl.amunanalytics.eu/getkey/) to retrieve your token. Fill it in where it says "INSERT_YOUR_USERNAME_HERE" and "INSERT_YOUR_TOKEN_HERE"
1. Click the "Run all" button at the top and see the code running. Click "Run anyway" if the warning popup comes up. First time it also installs the required packages, this can take a minute
1. You can now inspect the code and play with it and see the outputs!

If you are stuck feel free to contact me at [frank@amunanalytics.eu](mailto:frank@amunanalytics.eu)!

Alternatively you can run the notebook in your local notebook environment. In that case simply download it from github and run in your environment. If you have jupyterlab installed or running a local notebook you can also authenticate through an Oauth weblink. Sadly google colab does not support this. To use this create a cell at the top and paste in below code:

<pre>
from trino.auth import RedirectHandler, CompositeRedirectHandler, WebBrowserRedirectHandler

class CustomConsoleRedirectHandler(RedirectHandler):
    def __call__(self, url: str) -> None:
        print("Open the following URL in browser for the external authentication:")
        print(url)


REDIRECT_HANDLER = CompositeRedirectHandler([
        WebBrowserRedirectHandler(),
        CustomConsoleRedirectHandler()
])
</pre>

Then replace the cell with the connect call, in which it calls the get_access_token function, with below code:
<pre>
conn = connect(
    host=TRINO_URI,
    catalog="lakekeeper",
    auth=OAuth2Authentication(REDIRECT_HANDLER),
)
cur = conn.cursor()
</pre>
Now when you run a query for the first time it will print a url. If you click on it and are logged in through the Single Sign On it will authenticate the client for the rest of the session.

# Technical details datalake
The Amun Analytics datalake is build on top of Apache Iceberg using the [Lakekeeper catalog](https://docs.lakekeeper.io/). Data is stored in Cloudflare R2 object storage. The querying is done through [Trino](https://trino.io/docs/current/index.html). All authentication is done through single sign on, a selfhosted [Authentik instance](https://docs.goauthentik.io/). Authorization is all routed through [openfga](https://openfga.dev/) through an OPA bridge, managed by lakekeeper.
