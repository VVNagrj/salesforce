---

# Salesforce Visualforce Web-to-Lead & Opportunity Details Project Documentation (Visualforce)

---

## 1. Definitions (Project Fundamentals)

### 1.1 Visualforce Page

A **Visualforce page** is a Salesforce UI framework used to build custom user interfaces using HTML-like markup and Salesforce components.
In this project, Visualforce pages are used to:

* Build public web pages via Salesforce Sites
* Capture lead information using Web-to-Lead
* Display Opportunity and Opportunity Line Item details inside Salesforce

---

### 1.2 Salesforce Site

A **Salesforce Site** allows Visualforce pages to be accessed publicly without Salesforce login.

**Important Note (Caution):**

* Salesforce allows **only one active Site in a Developer Org**
* If you already have a Site:

  * Either use a **Sandbox**
  * Or deactivate the existing Site and activate the new one
* Activate **only one Site at a time**

---

### 1.3 Static Resource

A **Static Resource** is used to store reusable assets such as images, CSS, or JavaScript files.

In this project:

* Static Resources are used to store images
* These images are referenced inside Visualforce pages

---

## 2. Project Overview

This project demonstrates a **complete Visualforce-based Web-to-Lead flow** along with an **Opportunity Details display page**.

What we are implementing:

1. A **public landing page** to display product information
2. A **public Web-to-Lead form** to capture lead details
3. A **Thank You page** shown after successful submission
4. A **Visualforce page** to display Opportunity and Opportunity Line Item details inside Salesforce

---

## 3. Implementation Steps (Hands-On)

---

## Step 1: Static Resource Creation

### Purpose

To store and display images inside Visualforce pages.

### Steps

1. Go to **Setup → Static Resources**
2. Click **New**
3. Upload the image file (example: `thankYou.png`)
4. Name the resource (example: `thankYou`)
5. Save

This static resource will be used in the Thank You page.

---

## Step 2: Visualforce Page 1 – Landing Page

### Page Name

`Web2Lead_LandingPage`

### Purpose

* Acts as the **entry point** for users
* Displays product or service information
* Contains an **Enquire Now** link
* Publicly accessible via Salesforce Site

### Navigation Logic

In this project, navigation is handled using a **simple anchor tag**, not an Apex button.

```html
<a href="/w2l">Enquire Now</a>
```

**Important Clarification:**

* This is a **plain HTML anchor tag**
* It is **not an Apex command button**
* `/w2l` maps to the Web-to-Lead Visualforce page exposed via Site

Because this page is public, it can be shared externally to collect enquiries.

---

## Step 3: Visualforce Page 2 – Web-to-Lead Page

### Page Name

`Web2Lead_FormPage`

### Purpose

* Captures lead details
* Submits data directly into Salesforce CRM
* Publicly accessible via Salesforce Site

### Important Configuration Points

#### Organization ID (OID)

Replace the OID with your Salesforce Org ID:

```html
<input type="hidden" name="oid" value="00DXXXXXXXXXXXX" />
```

#### Custom Field Caution

* Salesforce generates **random field IDs** for custom fields
* Always verify field `name` values
* Replace them correctly before deployment

#### Redirect URL

After successful submission, the user is redirected to the Thank You page:

```html
<input type="hidden" name="retURL" value="https://yourSiteURL/apex/ThankYouPage" />
```

---

## Step 4: Visualforce Page 3 – Thank You Page

### Page Name

`ThankYouPage`

### Purpose

* Confirms successful form submission
* Displays a thank-you message with image

### Static Resource Image Mapping

```html
<img style="width: 50%;" src="{!URLFOR($Resource.thankYou)}" />
```

The image used here is stored as a Static Resource and is available in the Git repository.

---

## Step 5: Visualforce Page 4 – Opportunity Details Page

### Page Name

`OpportunityDetailsPage`

### Purpose

* Displays Opportunity details
* Displays related Opportunity Line Items
* Used **inside Salesforce org**, not public

### Apex Controller

`OpportunityDetailsController`

Responsibilities:

* Accept Opportunity Id as input
* Fetch Opportunity record
* Fetch related Opportunity Line Items

Controller binding:

```html
<apex:page controller="OpportunityDetailsController"
           showHeader="false"
           sidebar="false"
           docType="html-5.0">
```

---

## Step 6: Opportunity Button / Link Configuration

### Purpose

To open the Opportunity Details Visualforce page from an Opportunity record.

### Steps

1. Go to **Object Manager → Opportunity**
2. Open **Buttons, Links, and Actions**
3. Click **New Button or Link**
4. Display Type: Detail Page Button
5. Behavior: Display in new window
6. Content Source: URL

### URL Example

```
https://yourDomain--c.vf.force.com/apex/OpportunityDetailsPage?id={!Opportunity.Id}
```

When clicked:

* Opportunity Id is passed
* Visualforce page loads Opportunity and Line Item details

---

## 4. Salesforce Site Configuration

### Steps

1. Go to **Setup → Sites**
2. Register domain
3. Create new Site
4. Assign active Visualforce pages:

   * Web2Lead_LandingPage
   * Web2Lead_FormPage
   * ThankYouPage
5. Set landing page
6. Activate Site

---

## 5. Permissions Clarification (Important)

### Web-to-Lead Pages (Public)

Guest User requires:

* Lead object: Create
* Access to Visualforce pages
* Access to Static Resources

### Opportunity Details Page

* Used **inside Salesforce org**
* **No Guest User access required**
* Object permissions are handled by logged-in users
* No additional public permissions needed

---

## 6. Final Flow Summary

### Public Flow

Landing Page → Web-to-Lead Page → Thank You Page

### Internal Flow

Opportunity Record → View Details Button → Opportunity Details Visualforce Page

---
