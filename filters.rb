require 'gmail-britta'

fs = GmailBritta.filterset(:me => ['josh@joshuaspence.com',
                                   'joshua@joshuaspence.com',
                                   'josh@joshuaspence.com.au',
                                   'joshua@joshuaspence.com.au',
                                  ]) do
  # Bank: Commonwealth Bank
  bank = filter {
    has [{:or => [
      'cba.com.au',
      'commonwealthawards.com.au',
    ].map{|domain| "from:#{domain}"}}]
    label 'Bank'
  }.archive_unless_directed
  bank.also {
    has [
      'from:NetBankNotification@cba.com.au',
      {:or => [
        'New account statement',
        'New credit card statement',
      ].map{|subject| "subject:\"#{subject}\""}},
    ]
    label 'Bank/Statements'
    mark_important
    star
  }
  bank.also {
    has [
      'from:NetBankNotification@cba.com.au',
      {:or => [
        '"We were unable to process one of your scheduled transfers."',
        '"Your scheduled transfer was successfully processed."',
      ]},
      '"From account:"',
      '"To account:"',
      '"Description:"',
      '"Amount:"',
    ]
    archive
    label 'Bank/Transfers'
  }.also {
    has ['"Your scheduled transfer was successfully processed."']
    mark_read
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

  # Firearms: Newsletters
  filter {
    has [{:or => [
      'admin@nramedia.org',
      'sportingshooter@broadcast.yaffa.com.au',
    ].map{|email| "from:#{email}"}}]
    label 'Firearms/Newsletters'
  }.also {
    label 'Firearms'
  }

  # Howard and Sons
  filter {
    has ['from:howardsfireworks.com.au']
    label 'Howard and Sons'
  }.also {
    label 'Employment'
  }

  # Howard and Sons: Payslips
  filter {
    has [
      'from:noreply@xero.com',
      'replyto:kelly@howardsfireworks.com.au',
      "Here's your payslip",
      'filename:PaySlip.pdf',
    ]
    label 'Howard and Sons/Payslips'
    mark_important
    star
  }

  # Howard and Sons: Roster
  filter {
    has [
      'from:bang@howardsfireworks.com.au',
      'subject:"Roster"',
      'has:attachment',
    ]
    archive
    label 'Howard and Sons/Roster'
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

  # Projects (GitHub)
  github = filter {
    has ['from:notifications@github.com']
    label 'Projects'
  }

  # Projects (Phabricator)
  phabricator = filter {
    has ['from:noreply@phabricator.com']
    label 'Projects'
  }

  # Projects: arcanist
  github.also {
    has ['list:arcanist.facebook.github.com']
    label 'Projects/arcanist'
  }
  phabricator.also {
    has ['"ARCANIST PROJECT arcanist"']
    label 'Projects/arcanist'
  }

  # Projects: clean-css
  github.also {
    has ['list:clean-css.GoalSmashers.github.com']
    label 'Projects/clean-css'
  }

  # Projects: jshint
  github.also {
    has ['list:jshint.jshint.github.com']
    label 'Projects/jshint'
  }

  # Projects: less.js
  github.also {
    has ['list:less.js.less.github.com']
    label 'Projects/less.js'
  }

  # Projects: libphutil
  github.also {
    has ['list:libphutil.facebook.github.com']
    label 'Projects/libphutil'
  }
  phabricator.also {
    has ['"ARCANIST PROJECT libphutil"']
    label 'Projects/libphutil'
  }

  # Projects: Phabricator
  github.also {
    has ['list:phabricator.facebook.github.com']
    label 'Projects/Phabricator'
  }
  phabricator.also {
    has ['"ARCANIST PROJECT phabricator"']
    label 'Projects/Phabricator'
  }

  # Social: Calendar
  filter {
    has ['filename:invite.ics']
    label 'Social/Calendar'
  }

  # Social: Facebook
  filter {
    has [{:or => [
      'facebookmail.com',
    ].map{|email| "from:#{email}"}}]
    archive
    label 'Social/Facebook'
  }

  # Social: Foursquare
  filter {
    has [{:or => [
      'noreply@foursquare.com',
    ].map{|email| "from:#{email}"}}]
    archive
    label 'Social/Foursquare'
  }

  # Social: Google+
  filter {
    has [{:or => [
      'plus.google.com',
    ].map{|email| "from:#{email}"}}]
    archive
    label 'Social/Google+'
  }

  # Social: LinkedIn
  filter {
    has [{:or => [
      'group-digests@linkedin.com',
      'hit-reply@linkedin.com',
      'invitations-noreply@linkedin.com',
      'member@linkedin.com',
      'messages-noreply@linkedin.com',
      'notifications-noreply@linkedin.com',
    ].map{|email| "from:#{email}"}}]
    label 'Social/LinkedIn'
  }.also {
    has_not [{:or => [
      'hit-reply@linkedin.com',
      'member@linkedin.com',
    ].map{|email| "from:#{email}"}}]
    archive
  }

  # Social: Twitter
  filter {
    has [{:or => [
      'postmaster.twitter.com',
    ].map{|email| "from:#{email}"}}]
    archive
    label 'Social/Twitter'
  }

  # Newsletters
  filter {
    has [{:or => [
      {:or => [
        'If you no longer want us to contact you',
        'Rather not receive future emails',
        'Remove yourself from this list',
        'To stop receiving emails',
        'Unsubscribe here',
        'Unsubscribe from our mailing list',
        'Unsubscribe from this list',
        'Update subscription preferences',
      ].map{|text| "\"#{text}\""}},

      # Blacklisted senders
      {:or => [
        'admin@nramedia.org',
        'online@email.commonwealthawards.com.au',
        'sportingshooter@broadcast.yaffa.com.au',
      ].map{|email| "from:#{email}"}},
    ]}]
    has_not [
      # Whitelisted senders
      {:or => [
        'NetBankNotification@cba.com.au',
      ].map{|email| "from:#{email}"}},
    ]
    archive
    label 'Newsletters'
    mark_unimportant
  }

  # Orders
  filter {
    has [{:or => [
      {:or => [
        'Confirmation number',
        'Order confirmation',
        'Order details',
        'Order has shipped',
        'Shipping confirmation',
        'Tracking number',
      ].map{|text| "\"#{text}\""}},

      # Blacklisted senders
      {:or => [
        'auto-confirm@amazon.com',
        'order-update@amazon.com',
        'ship-confirm@amazon.com',
      ].map{|email| "from:#{email}"}},
    ]}]
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

  # Vehicle (Roam)
  filter {
    has ['roam.com.au']
    label 'Vehicle'
  }.archive_unless_directed.also {
    has [
      'from:enquiries@e.roam.com.au',
      'subject:"Your Roam Statement is available online"',
    ]
    label 'Invoices'
    mark_important
    star
  }

  # Web: Amazon Web Services
  filter {
    has [{:or => [
      'no-reply-aws@amazonaws.com',
    ].map{|email| "from:#{email}"}}]
    label 'Web/Amazon Web Services'
  }.archive_unless_directed.also {
    label 'Web'
  }

  # Web: Digital Pacific
  filter {
    has [{:or => [
      'monitoring@digitalpacific.com.au',
      'noreply@digitalpacific.com.au',
      'support@digitalpacific.com.au',
    ].map{|email| "from:#{email}"}}]
    label 'Web/Digital Pacific'
  }.archive_unless_directed.also {
    label 'Web'
  }
end
puts fs.generate
