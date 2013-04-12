#!/bin/env ruby

require 'bundler/setup'
require 'gmail-britta'

fs = GmailBritta.filterset(:me => [ 'josh@joshuaspence.com',
                                    'joshua@joshuaspence.com',
                                    'josh@joshuaspence.com.au',
                                    'joshua@joshuaspence.com.au',
                                    'josh@freelancer.com' ]) do
  
  # Bank: Commonwealth Bank
  filter {
    has [{:or => [
      'cba.com.au',
      'commonwealthawards.com.au',
    ].map{|email| "from:#{email}"}}]
    label 'Bank'
  }.archive_unless_directed.also {
    # Bank statements
    has [
      'from:NetBankNotification@cba.com.au',
      {:or => [
        'new statement',
        'new account statement',
        'new credit card statement',
      ].map{|subject| "subject:\"#{subject}\""}},
    ]
    label 'Invoices'
    mark_important
    star
  }

  # Social: about.me
  filter {
    has [{:or => [
      'aboutme@about.me',
    ].map{|email| "from:#{email}"}}]
    label 'Bulk/Social'
    archive
  }

  # Social: Facebook
  filter {
    has [{:or => [
      'facebookmail.com',
    ].map{|email| "from:#{email}"}}]
    label 'Bulk/Social'
    archive
  }

  # Social: Foursquare
  filter {
    has [{:or => [
      'noreply@foursquare.com',
    ].map{|email| "from:#{email}"}}]
    label 'Bulk/Social'
    archive
  }

  # Social: Google+
  filter {
    has [{:or => [
      'plus.google.com',
    ].map{|email| "from:#{email}"}}]
    label 'Bulk/Social'
    archive
  }

  # Social: LinkedIn
  filter {
    has [{:or => [
      'connections@linkedin.com',
      'e.linkedin.com',
      'group-digests@linkedin.com',
      'hit-reply@linkedin.com',
      'invitations@linkedin.com',
      'jobs-listings@linkedin.com',
      'linkedin@em.linkedin.com',
      'member@linkedin.com',
      'messages-noreply@linkedin.com',
      'updates@linkedin.com',
      'welcome@linkedin.com',
    ].map{|email| "from:#{email}"}}]
    label 'Bulk/Social'
    archive
  }

  # Social: Twitter
  filter {
    has [{:or => [
      'postmaster.twitter.com',
    ].map{|email| "from:#{email}"}}]
    label 'Bulk/Social'
    archive
  }

  # Notes
  filter {
    has [
      {:or => me.map{|email| "from:#{email}"}},
      {:or => me.map{|email| "to:#{email}"}}
    ]
    label 'Notes'
    mark_important
    never_spam
    star
  }

  # Family
  filter {
    has [{:or => [
      'mspence@thehills.nsw.gov.au',
      'spencej@bigpond.net.au',
      'lisson@optusnet.com.au',
    ].map{|email| "from:#{email}"}}]
    label 'Family'
  }

  # Newsletters
  filter {
    # Generic
    has [{:or => [
      'opt-out',
      'unsubscribe',
      'viewing the newsletter',
      'to view this email as a web page',
      'read the online version',
      'newsletter',
      'newsletters',
      'subscriptions',
    ].map{|text| "\"#{text}\""}}]
  }.also {
    # eBay exclusion
    has_not [
      'from:ebay@ebay.com.au',
      'subject:"Your eBay item sold"',
    ]
  }.also {
    # LinkedIn exclusion
    has_not [{:or => [
      'connections@linkedin.com',
      'hit-reply@linkedin.com',
      'member@linkedin.com',
    ].map{|email| "from:#{email}"}}]
  }.also {
    # Telstra exclusion
    has_not [
      'from:online.telstra.com.au',
      'subject:"Your Telstra Email Bill"',
    ]
  }.also {
    archive
    label 'Bulk/Newsletters'
    mark_unimportant
  }

  # University
  filter {
    has [{:or => [
      [
        'usyd.edu.au',
        'sydney.edu.au',
      ].map{|email| "from:#{email}"},
      'to:jspe9969@uni.sydney.edu.au',
    ]}]
    label 'University'
  }.archive_unless_directed

  # Vehicle: Roam
  filter {
    has [ 'roam.com.au' ]
    label 'Vehicle'
  }.archive_unless_directed

  # Vehicle: RTA
  filter {
    has [ 'from:rta.nsw.gov.au' ]
    label 'Vehicle'
  }.archive_unless_directed

  # Phone: Telstra
  filter {
    has [ 'from:online.telstra.com.au' ]
    label 'Phone'
  }.also {
    # Phone bill
    has [
      'from:info@online.telstra.com.au',
      {:or => [
        'Telstra Bill - Arrival Notification',
        'Your Telstra Email Bill',
      ].map{|subject| "subject:\"#{subject}\""}},
    ]
    label 'Invoices'
    mark_important
    star
  }

  # Invoices: Generic
  filter {
    has [
      {:or => [
        'Receipt',
        'Invoice',
        'has:attachment',
      ]},
      {:or => [
        'Invoice',
        'Receipt',
        'Order',
      ].map{|subject| "subject:\"#{subject}\""}}
    ]
    label 'Invoices'
    mark_important
    star
  }

  # Invoices: eBay
  filter {
    has [
      {:or => [
        'billing@ebay.com.au',
        'ebay@ebay.com.au',
      ].map{|email| "from:#{email}"}},
      {:or => [
        'Your invoice for eBay purchases',
        'eBay Invoice Notification',
      ].map{|subject| "subject:\"#{subject}\""}},
    ]
    label 'Invoices'
    mark_important
    star
  }

  # Invoices: Paypal
  filter {
    has [
      'from:service@paypal.com.au',
      'subject:"Receipt for your payment"',
    ]
    label 'Invoices'
    mark_important
    star
  }

  # Firearms: Dealers
  filter {
    has [{:or => [
      'brownells.com',
      'cleaverfirearms.com',
      'safarifirearms.com.au',
    ].map{|email| "from:#{email}"}}]
    label 'Firearms/Dealers'
  }.archive_unless_directed.also {
    label 'Firearms'
  }

  # Firearms: Sporting Shooter newsletter
  filter {
    has [{:or => [
      'sportingshooter@broadcast.yaffa.com.au',
    ].map{|email| "from:#{email}"}}]
    label 'Firearms'
  }.archive_unless_directed

  # Web: Amazon Web Services
  filter {
    has [{:or => [
      'no-reply-aws@amazonaws.com',
    ].map{|email| "from:#{email}"}}]
    label 'Web'
  }.archive_unless_directed

  # Web: Digital Pacific
  filter {
    has [{:or => [
      'monitoring@digitalpacific.com.au',
      'noreply@digitalpacific.com.au',
      'support@digitalpacific.com.au',
    ].map{|email| "from:#{email}"}}]
    label 'Web'
  }.archive_unless_directed

  # Employment: Howard and Sons
  filter {
    has [{:or => [
      'howardsfireworks.com.au',
      'chris@mbjtech.com.au',
    ].map{|email| "from:#{email}"}}]
    label 'Employment/Howard and Sons'
  }.also {
    label 'Employment'
  }.also {
    # Payslips
    has [{:or => [
      'Payslip',
      'From Howard & Sons Pyrotechnics (Displays) PL',
    ].map{|subject| "subject:\"#{subject}\""}}]
    label 'Employment/Payslips'
    mark_important
    star
  }

  # Employment: LinkedIn
  filter {
    has [{:or => [
      'jobs-listings@linkedin.com',
    ].map{|email| "from:#{email}"}}]
    label 'Employment'
  }.archive_unless_directed

  # Orders: Generic
  filter {
    has [{:or => [
      'order number',
      'confirmation',
      'shipping confirmation',
      'order has shipped',
      'tracking number',
    ]}]
    label 'Orders'
    mark_important
  }

  # Orders: Amazon
  filter {
    has [{:or => [
      'auto-confirm@amazon.com',
      'order-update@amazon.com',
      'ship-confirm@amazon.com',
      'auto-confirm@amazon.co.uk',
      'order-update@amazon.co.uk',
      'ship-confirm@amazon.co.uk',
    ].map{|email| "from:#{email}"}}]
    label 'Orders'
    mark_important
  }

  # Orders: eBay
  filter {
    has [
      'from:ebay@ebay.com.au',
      {:or => [
        'Confirmation of your order',
        'Updates for your purchase',
        'Your invoice for eBay purchases',
      ].map{|subject| "subject:#{subject}"}},
    ]
    label 'Orders'
    mark_important
  }

  # Utility: Emails sent to my old email address
  filter {
    has [ 'to:joshua.james.spence@gmail.com' ]
    label 'Bulk/Sent to old email address'
  }

  # Blacklist: MSY newsletter
  filter {
    has [
      'from:noreply@news.msy.com.au',
      'to:joshua.james.spence@gmail.com',
      'newsletter',
    ]
    delete_it
  }
end
puts fs.generate
