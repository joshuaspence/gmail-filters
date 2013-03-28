#!/bin/env ruby

require 'bundler/setup'
require 'gmail-britta'

#===============================================================================
# Configuration
#-------------------------------------------------------------------------------
TEST_EMAILS = [
  'josh+freelancer@freelancer.com'
]

FREELANCER_DOMAINS = [
  '@freelancer.com'
]
#===============================================================================

fs = GmailBritta.filterset(:me => [ 'josh@freelancer.com' ]) do
  # Competitor coverage
  filter {
    has [
      'from:kevin@freelancer.com',
      'subject:"Competitor Coverage"'
    ]
    label 'Competitors/Competitor Coverage'
  }.archive_unless_directed
  
  # Elance
  filter {
    has [ 'from:@elance.com' ]
    label 'Competitors'
  }.archive_unless_directed.also {
    label 'Competitors/Elance'
  }
  
  # Freelancer
  filter {
    has [
      {:or => FREELANCER_DOMAINS.map{|domain| "from:#{domain}"}},
      {:or => TEST_EMAILS.map{|email| "to:#{email}"}}
    ]
    label 'Competitors'
  }.also {
    label 'Competitors/Freelancer'
  }.also {
    has [ 'subject:"Latest projects and contests matching your skills"' ]
    archive
    mark_read
  }
  
  # Odesk
  filter {
    has [ 'from:@odesk.com' ]
    label 'Competitors'
  }.archive_unless_directed.also {
    label 'Competitors/Odesk'
  }
  
  # PeoplePerHour
  filter {
    has [ 'from:@peopleperhour.com' ]
    label 'Competitors'
  }.archive_unless_directed.also {
    label 'Competitors/PeoplePerHour'
  }.also {
    has [ 'subject:"New Jobs match your search results"' ]
    archive
    mark_read
  }
  
  # Tech
  filter {
    has [
      {
        :or => [
          'http://techcrunch.com',
          'http://venturebeat.com',
          'http://www.theverge.com',
          'http://www.buzzfeed.com',
          'http://www.seomez.org'
        ]
      }
    ]
    label 'Tech'
  }.also {
    label 'Tech/Articles'
  }
  
  # Daily stats
  filter {
    has [
      'from:@freelancer.com',
      'subject:"Daily Stats"'
    ]
    label 'Growth'
  }.also {
    label 'Growth/Daily Stats'
  }
  
  # Bulk emails
  filter {
    has [
      {
        :or => [
          'www-data@freelancer.com'
        ].map{|email| "from:#{email}"}
      }
    ]
    label 'Bulk'
  }.archive_unless_directed.also {
    has [ 'subject:"rejoined memberships"' ]
    archive
    mark_read
  }
  
  # Dashboard bulk emails
  filter {
    has [ 'from:dashboard@freelancer.com' ]
  }.archive_unless_directed.also {
    has [ 'subject:"Emergency values"' ]
    label 'Bulk/Dashboard'
  }
end
puts fs.generate
