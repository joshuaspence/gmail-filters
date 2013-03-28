#!/bin/env ruby

require 'bundler/setup'
require 'gmail-britta'

#===============================================================================
# Configuration
#-------------------------------------------------------------------------------
MY_EMAILS = [
  'josh@joshuaspence.com',
  'joshua@joshuaspence.com',
  'josh@joshuaspence.com.au',
  'joshua@joshuaspence.com.au',
  'josh@freelancer.com'
]
BANK_EMAILS = [
  '@cba.com.au',
  '@commonwealthawards.com.au',
  'NetBankNotification@cba.com.au'
]
BANK_STATEMENT_SUBJECT = [
  '"new statement"',
  '"new account statement"',
  '"new credit card statement"'
]
FAMILY_EMAILS = [
  'mspence@thehills.nsw.gov.au',
  'spencej@bigpond.net.au',
  'lisson@optusnet.com.au'
]
SOCIAL_EMAILS = [
  'aboutme@about.me',
  '@facebook.com',
  '@facebookmail.com',
  'member@linkedin.com',
  'connections@linkedin.com',
  '@twitter.com'
]
#===============================================================================

fs = GmailBritta.filterset(:me => MY_EMAILS) do
  # Bank
  filter {
    has [{:or => BANK_EMAILS.map{|email| "from:#{email}"}}]
    label 'Bank'
    mark_important
  }.also {
    has [{:or => BANK_STATEMENT_SUBJECT.map{|subject| "subject:#{subject}"}}]
    label 'Invoices'
    star
  }
  
  # Social
  filter {
    has [{:or => SOCIAL_EMAILS.map{|email| "from:#{email}"}}]
    label 'Bulk/Social'
    archive
    mark_read
    mark_unimportant
  }
  
  # Notes
  filter {
    has [
      {:or => MY_EMAILS.map{|email| "from:#{email}"}},
      {:or => MY_EMAILS.map{|email| "to:#{email}"}}
    ]
    label 'Notes'
    mark_important
    never_spam
    star
  }
  
  # Family
  filter {
    has [{:or => FAMILY_EMAILS.map{|email| "from:#{email}"}}]
    label 'Family'
  }
  
  # Newsletters
  filter {
    has [{:or =>
      [
        'opt-out',
        'unsubscribe',
        '"viewing the newsletter"',
        '"to view this email as a web page"',
        '"read the online version"',
        'newsletter',
        'newsletters',
        'subscriptions'
        ]
    }]
    has_not [
      'member@linkedin.com',
      'connections@linkedin.com',
      'hit-reply@linkedin.com'
    ].map{|email| "from:#{email}"}
    label 'Bulk/Newsletters'
    mark_unimportant
  }.archive_unless_directed
  
  # University
  filter {
    has [{:or => [
      {:or =>
        [
          '@usyd.edu.au',
          '@sydney.edu.au'
        ].map{|email| "from:#{email}"}
      },
      {:or => ['jspe9969@uni.sydney.edu.au'].map{|email| "to:#{email}"}}
    ]}]
    label 'University'
  }.archive_unless_directed
  
  # Vehicle
  filter {
    has [{:or =>
      [
        '@rta.nsw.gov.au',
        '@roam.com.au'
      ].map{|email| "from:#{email}"}
    }]
    label 'Vehicle'
  }.archive_unless_directed.also {
    has [
      'from:enquiries@roam.com.au',
      'subject:"Your Roam Statement is available online"'
    ]
    label 'Invoices'
    mark_important
    star
  }.archive_unless_directed
  
  # Utility
  filter {
    has [{:or => ['joshua.james.spence@gmail.com'].map{|email| "to:#{email}"}}]
    label 'Bulk/Sent to old email address'
  }
  
  # eBay
  filter {
    has [{:or => ['ebay@ebay.com.au', 'billing@ebay.com.au'].map{|email| "from:#{email}"}}]
  }.also {
    has [{:or => ['"Your invoice for eBay purchases:"', '"eBay Invoice Notification"'].map{|subject| "subject:#{subject}"}}]
    label 'Invoices'
    mark_important
    star
  }
  
  # Paypal
  filter {
    has [{:or => ['service@paypal.com.au'].map{|email| "from:#{email}"}}]
  }.also {
    has [{:or => ['"Receipt for your"'].map{|subject| "subject:#{subject}"}}]
    label 'Invoices'
    mark_important
    star
  }
  
  # Phone
  filter {
    has [{:or => ['@online.telstra.com.au'].map{|email| "from:#{email}"}}]
    label 'Phone'
  }.also {
    has [{:or => ['"Telstra Bill - Arrival Notification"', '"Your Telstra Email Bill"'].map{|subject| "subject:#{subject}"}}]
    has_attachment
    label 'Invoices'
    mark_important
    star
  }
  
  # Invoices
  filter {
    has [
      {:or => ['Receipt', 'Invoice', 'has:attachment']},
      {:or => ['Invoice', 'Receipt', 'Order'].map{|subject| "subject:#{subject}"}}
    ]
    label 'Invoices'
    mark_important
    star
  }.archive_unless_directed
  
  # Firearms
  filter {
    has ['from:sportingshooter@broadcast.yaffa.com.au']
    label 'Firearms'
  }
  filter {
    has [{:or =>
      [
        '@brownells.com',
        '@cleaverfirearms.com',
        '@safarifirearms.com.au'
      ].map{|email| "from:#{email}"}
    }]
    label 'Firearms'
  }.also {
    label 'Firearms/Dealers'
  }
  
  # Web
  filter {
    has [{:or =>
      [
        '@digitalpacific.com.au'
      ].map{|email| "from:#{email}"}
    }]
    label 'Web'
  }
  
  # Work
  filter {
    has [{:or =>
      [
        '@howardsfireworks.com.au',
        'chris@mbjtech.com.au'
      ].map{|email| "from:#{email}"}
    }]
    label = 'Work/Howard and Sons'
  }.also {
    has [{:or =>
      [
        'Payslip',
        '"From Howard & Sons Pyrotechnics (Displays) PL"'
      ].map{|subject| "subject:#{subject}"}
    }]
    label = 'Work/Payslips'
    mark_important
    star
  }
  
  # Order
  filter {
    has [
      '"order number"',
      'confirmation'
    ]
    label 'Orders'
    mark_important
  }
end
puts fs.generate
