#!/usr/bin/env ruby

require 'bundler/setup'
require 'gmail-britta'

fs = GmailBritta.filterset(:me => ['josh@joshuaspence.com',
                                   'joshua@joshuaspence.com',
                                   'josh@joshuaspence.com.au',
                                   'joshua@joshuaspence.com.au',
                                  ]) do

  # Bank: Commonwealth Bank
  filter {
    has [{:or => [
      'cba.com.au',
      'commonwealthawards.com.au',
    ].map{|email| "from:#{email}"}}]
    label 'Bank'
  }.archive_unless_directed

  # Bank: Commonwealth Bank (Statements)
  filter {
    has [
      'from:NetBankNotification@cba.com.au',
      {:or => [
        'new statement',
        'new account statement',
        'new credit card statement',
      ].map{|subject| "subject:\"#{subject}\""}},
    ]
    label 'Invoices'
  }.also {
    label 'Bank'
  }.also {
    mark_important
    star
  }

  # Employment: Howard and Sons
  filter {
    has ['from:howardsfireworks.com.au']
    label 'Employment/Howard and Sons'
  }.also {
    label 'Employment'
  }

  # Employment: Howard and Sons (Payslips)
  filter {
    has [
      'from:kayla@howardsfireworks.com.au',
      'subject:"From Howard & Sons Pyrotechnics (Displays) PL"',
      '"Pay Slip"',
      'has:attachment',
    ]
    label 'Employment/Payslips'
  }.also {
    label 'Employment/Howard and Sons'
  }.also {
    mark_important
    star
  }

  # Employment: Howard and Sons (Roster)
  filter {
    has [
      'from:bang@howardsfireworks.com.au',
      'subject:"Roster"',
      'has:attachment',
    ]
    label 'Employment/Howard and Sons'
  }.also {
    archive
  }

  # Family
  filter {
    has [{:or => [
      'mspence@thehills.nsw.gov.au',
      'spencej@bigpond.net.au',
      'pink_rayne911@hotmail.com',
      'lisson@optusnet.com.au',
    ].map{|email| "from:#{email}"}}]
    label 'Family'
  }

  # Firearms: Dealers
  filter {
    has [{:or => [
      'brownells.com',
      'cleaverfirearms.com',
      'gunsngear.com.au',
      'safarifirearms.com.au',
    ].map{|email| "from:#{email}"}}]
    label 'Firearms/Dealers'
  }.archive_unless_directed.also {
    label 'Firearms'
  }

  # Firearms: Political
  filter {
    has [{:or => [
      'Robert.Borsak@parliament.nsw.gov.au',
      'Robert.Brown@parliament.nsw.gov.au',
    ].map{|email| "from:#{email}"}}]
    label 'Firearms'
  }.archive_unless_directed

  # Firearms: Registry
  filter {
    has [{:or => [
      'dealers@police.nsw.gov.au',
      'firearmsenq@police.nsw.gov.au',
    ].map{|email| "from:#{email}"}}]
    label 'Firearms/Registry'
  }.also {
    label 'Firearms'
  }

  # Firearms: Sporting Shooter newsletter
  filter {
    has [{:or => [
      'sportingshooter@broadcast.yaffa.com.au',
    ].map{|email| "from:#{email}"}}]
    label 'Firearms'
  }.archive_unless_directed.also {
    label 'Bulk/Newsletters'
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
  }.also {
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
  }.also {
    mark_important
    star
  }

  # Invoices: Paypal
  filter {
    has [
      'from:service@paypal.com.au',
      {:or => [
        'Receipt for your payment',
        'You sent an automatic payment',
      ].map{|subject| "subject:\"#{subject}\""}},
    ]
    label 'Invoices'
  }.also {
    mark_important
    star
  }

  # Notes
  filter {
    has [
      {:or => me.map{|email| "from:#{email}"}},
      {:or => me.map{|email| "to:#{email}"}}
    ]
    label 'Notes'
  }.also {
    never_spam
    star
  }

  # Social: Facebook
  filter {
    has [{:or => [
      'facebookmail.com',
    ].map{|email| "from:#{email}"}}]
    label 'Bulk/Social'
  }.also {
    archive
  }

  # Social: Foursquare
  filter {
    has [{:or => [
      'noreply@foursquare.com',
    ].map{|email| "from:#{email}"}}]
    label 'Bulk/Social'
  }.also {
    archive
  }

  # Social: Google+
  filter {
    has [{:or => [
      'plus.google.com',
    ].map{|email| "from:#{email}"}}]
    label 'Bulk/Social'
  }.also {
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
  }.also {
    has_not [{:or => [
      'hit-reply@linkedin.com',
    ].map{|email| "from:#{email}"}}]
    archive
  }

  # Social: Twitter
  filter {
    has [{:or => [
      'postmaster.twitter.com',
    ].map{|email| "from:#{email}"}}]
    label 'Bulk/Social'
  }.also {
    archive
  }

  # Newsletters
  filter {
    # Generic
    has [{:or => [
      'email campaigns',
      'latest news',
      'manage preferences',
      'notification settings',
      'product announcements',
      'product updates',
      'read the online version',
      'remove yourself from this list',
      'unsubscribe',
      'unsubscribe from this list',
      'unsubscribe from this mailing list',
      'update subscription preferences',
      'viewing the newsletter',
    ].map{|text| "\"#{text}\""}}]
  }.also {
    # eBay exclusion
    has_not [
      'from:ebay@ebay.com.au',
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
      {:or => [
        'online.telstra.com',
        'online.telstra.com.au',
      ].map{|email| "from:#{email}"}},
      'subject:"Telstra bill for account"',
    ]
  }.also {
    label 'Bulk/Newsletters'
  }.also {
    archive
    mark_unimportant
  }

  # Newsletters: Blacklist
  filter {
      has [{:or => [
        'news.telstra.com',
      ].map{|email| "from:#{email}"}}]
    }.also {
      archive
      mark_unimportant
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
  }

  # Orders: eBay
  filter {
    has [
      'from:ebay@ebay.com.au',
      {:or => [
        'Confirmation of your order',
        'Updates for your purchase',
        'Your invoice for eBay purchases',
      ].map{|subject| "subject:\"#{subject}\""}},
    ]
    label 'Orders'
  }

  # Orders: Generic
  filter {
    has [{:or => [
      'order number',
      'confirmation',
      'shipping confirmation',
      'order has shipped',
      'tracking number',
    ].map{|text| "\"#{text}\""}}]
    label 'Orders'
  }

  # Phone: Telstra
  filter {
    has [{:or => [
      'online.telstra.com',
      'online.telstra.com.au',
    ].map{|email| "from:#{email}"}}]
    label 'Phone'
  }.archive_unless_directed.also {
    # Phone bill
    has [
      'subject:"Telstra bill for account"',
      'has:attachment',
    ]
    label 'Invoices'
  }.also {
    mark_important
    star
  }

  # University
  filter {
    has [{:or => [
      [
        'sydney.edu.au',
        'usyd.edu.au',
      ].map{|email| "from:#{email}"},
      'to:jspe9969@uni.sydney.edu.au',
    ]}]
    label 'University'
  }.archive_unless_directed

  # Utility: Blacklist (MSY newsletter)
  filter {
    has [
      'from:noreply@news.msy.com.au',
      'to:joshua.james.spence@gmail.com',
      'newsletter',
    ]
    delete_it
  }

  # Utility: Emails sent to my old email address
  filter {
    has ['to:joshua.james.spence@gmail.com']
    label 'Bulk/Sent to old email address'
  }

  # Vehicle: Roam
  filter {
    has ['roam.com.au']
    label 'Vehicle'
  }.archive_unless_directed

  # Vehicle: Roam (Statements)
  filter {
    has [
      'from:enquiries@e.roam.com.au',
      'subject:"Your Roam Statement is available online"',
    ]
    label 'Invoices'
  }.also {
    label 'Vehicle'
  }.also {
    mark_important
    star
  }

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
end
puts fs.generate
