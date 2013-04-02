#!/bin/env ruby

require 'bundler/setup'
require 'gmail-britta'

fs = GmailBritta.filterset(:me => [ 'josh@joshuaspence.com', 'joshua@joshuaspence.com', 'josh@joshuaspence.com.au', 'joshua@joshuaspence.com.au', 'josh@freelancer.com' ]) do
  # Bank
  filter {
    has [
      {
        :or => [
          'cba.com.au',
          'commonwealthawards.com.au',
        ].map{|email| "from:#{email}"}
      }
    ]
    label 'Bank'
  }.archive_unless_directed

  # Social
  filter {
    has [
      {
        :or => [
          # about.me
          'aboutme@about.me',

          # Facebook
          'facebookmail.com',

          # Foursquare
          'noreply@foursquare.com',

          # Google Plus
          'plus.google.com',

          # LinkedIn
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

          # Twitter
          'postmaster.twitter.com'
        ].map{|email| "from:#{email}"}
      }
    ]
    label 'Bulk/Social'
    archive
    mark_unimportant
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
    has [
      {
        :or => [
          'mspence@thehills.nsw.gov.au',
          'spencej@bigpond.net.au',
          'lisson@optusnet.com.au'
        ].map{|email| "from:#{email}"}
      }
    ]
    label 'Family'
  }

  # Newsletters
  filter {
    has [
      # Generic
      {
        :or => [
          'opt-out',
          'unsubscribe',
          '"viewing the newsletter"',
          '"to view this email as a web page"',
          '"read the online version"',
          'newsletter',
          'newsletters',
          'subscriptions'
          ]
      },

      # eBay exclusion
      {
        :not => [
          'from:ebay@ebay.com.au',
          'subject:"Your eBay item sold"'
        ]
      },

      # LinkedIn exclusion
      {
        :not => {
          :or => [
            'connections@linkedin.com',
            'hit-reply@linkedin.com',
            'member@linkedin.com'
          ].map{|email| "from:#{email}"}
        }
      },

      # Telstra exclusion
      {
        :not => [
          'from:online.telstra.com.au',
          'subject:"Your Telstra Email Bill"'
        ]
      }
    ]
    archive
    label 'Bulk/Newsletters'
    mark_unimportant
  }

  # University
  filter {
    has [
      {
        :or => [
          [
            'usyd.edu.au',
            'sydney.edu.au'
          ].map{|email| "from:#{email}"},
          'to:jspe9969@uni.sydney.edu.au'
        ]
      }
    ]
    label 'University'
  }.archive_unless_directed

  # Vehicle
  filter {
    has [
      {
        :or => [
          'rta.nsw.gov.au',
          'roam.com.au'
        ].map{|email| "from:#{email}"}
      }
    ]
    label 'Vehicle'
  }.archive_unless_directed

  # Utility
  filter {
    has [ 'to:joshua.james.spence@gmail.com' ]
    label 'Bulk/Sent to old email address'
  }

  # eBay
  filter {
    has [
      {
        :or => [
          'billing@ebay.com.au',
          'ebay@ebay.com.au',
          'ebay@reply.ebay.com.au',
          'members.ebay.com.au',
        ].map{|email| "from:#{email}"}
      }
    ]
  }.also {
    has [
      'from:ebay@ebay.com.au',
      {
        :or => [
          '"Confirmation of your order"',
          '"Updates for your purchase"',
          '"Your invoice for eBay purchases"'
        ].map{|subject| "subject:#{subject}"}
      }
    ]
    label 'Orders'
    mark_important
  }

  # Phone
  filter {
    has [ 'from:online.telstra.com.au' ]
    label 'Phone'
  }

  # Invoices
  filter {
    has [
      {
        :or => [
          # Generic
          [
            {
              :or => [
                'Receipt',
                'Invoice',
                'has:attachment'
              ]
            },
            {
              :or => [
                'Invoice',
                'Receipt',
                'Order'
              ].map{|subject| "subject:#{subject}"}
            }
          ],

          # Telstra phone bill
          [
            'from:info@online.telstra.com.au',
            {
              :or => [
                '"Telstra Bill - Arrival Notification"',
                '"Your Telstra Email Bill"'
              ].map{|subject| "subject:#{subject}"}
            }
          ],

          # Commonwealth Bank statements
          [
            'from:NetBankNotification@cba.com.au',
            {
              :or => [
                '"new statement"',
                '"new account statement"',
                '"new credit card statement"'
              ].map{|subject| "subject:#{subject}"}
            }
          ],

          # eBay
          [
            {
              :or => [
                'billing@ebay.com.au',
                'ebay@ebay.com.au',
              ].map{|email| "from:#{email}"}
            },
            {
              :or => [
                '"Your invoice for eBay purchases:"',
                '"eBay Invoice Notification"'
              ].map{|subject| "subject:#{subject}"}
            }
          ]

          # Paypal
          [
            'from:service@paypal.com.au',
            'subject:"Receipt for your payment"'
          ]
        ]
      }
    ]
    label 'Invoices'
    mark_important
    star
  }

  # Firearms
  filter {
    has [
      {
        :or => [
          'sportingshooter@broadcast.yaffa.com.au'
        ].map{|email| "from:#{email}"}
      }
    ]
    label 'Firearms'
  }.archive_unless_directed
  filter {
    has [
      {
        :or => [
          'brownells.com',
          'cleaverfirearms.com',
          'safarifirearms.com.au'
        ].map{|email| "from:#{email}"}
      }
    ]
    label 'Firearms'
  }.archive_unless_directed.also {
    label 'Firearms/Dealers'
  }

  # Web
  filter {
    has [
      {
        :or => [
          'monitoring@digitalpacific.com.au',
          'noreply@digitalpacific.com.au',
          'support@digitalpacific.com.au',
          'no-reply-aws@amazonaws.com'
        ].map{|email| "from:#{email}"}
      }
    ]
    label 'Web'
  }.archive_unless_directed

  # Employment
  filter {
    has [
      {
        :or => [
          'jobs-listings@linkedin.com'
        ].map{|email| "from:#{email}"}
      }
    ]
    label 'Employment'
  }.archive_unless_directed
  filter {
    has [
      {
        :or => [
          'howardsfireworks.com.au',
          'chris@mbjtech.com.au'
        ].map{|email| "from:#{email}"}
      }
    ]
    label 'Employment'
  }.also {
    label 'Employment/Howard and Sons'
  }.also {
    has [
      {
        :or => [
          'Payslip',
          '"From Howard & Sons Pyrotechnics (Displays) PL"'
        ].map{|subject| "subject:#{subject}"}
      }
    ]
    label 'Employment/Payslips'
    mark_important
    star
  }

  # Order
  filter {
    has [
      {
        :or => [
          # Generic
          {
            :or => [
              '"order number"',
              'confirmation',
              '"shipping confirmation"',
              '"order has shipped"',
              '"tracking number"',
            ]
          },

          # Amazon
          {
            :or => [
              'auto-confirm@amazon.com',
              'order-update@amazon.com',
              'ship-confirm@amazon.com',
              'auto-confirm@amazon.co.uk',
              'order-update@amazon.co.uk',
              'ship-confirm@amazon.co.uk'
            ].map{|email| "from:#{email}"}
          }
        ]
      }
    ]
    label 'Orders'
    mark_important
  }

  # Permaban
  filter {
    has [
      {
        :or => [
          # MSY newsletter
          [
            'from:noreply@news.msy.com.au',
            'to:joshua.james.spence@gmail.com',
            'newsletter',
          ]
        ]
      }
    ]
    delete_it
    mark_read
    mark_unimportant
  }
end
puts fs.generate
