billit_representers
===================

Representers for the [bill-it component](https://github.com/ciudadanointeligente/bill-it) of the [Poplus project](http://poplus.org). These provide object-like access to remote data, adding variables, validations and HTTP verb methods to local objects. This is implemented with Resource-Oriented Architectures in Ruby ([ROAR](https://github.com/apotonick/roar)).

#Installation
Make sure you have ruby 2.0 installed. If not visit https://rvm.io/rvm/install.

To install gem locally
```
gem install billit_representers
```

or add gem to your Gemfile to install with [bundler](http://bundler.io/).
```
gem 'billit_representers'
```

#Usage
##Adding representations to local model
Include in local model to add bill attributes, validations and HTTP verb methods.
```
require 'billit_representers/representers/bill_representer'
class Bill
  include Billit::BillRepresenter
end
```
Some bill attributes require their own models to be created. In this particular bill model these are:
- Directive
- Document
- Paperwork
- Priority
- Remark
- Report
##Using models included in the representer
This is the preferred option if bill information is fetched and no persistence is needed.
TO DO
##Validations
Bills require some attributes to exist or to have restricted values.
```
Bill.class_variables
#=> list of class variables, which hold valid values for validated attributes
Bill.class_variable_get(:@@matters_valid_values)
#=> receives a class variable name, returns list of valid values for, in this example, the attribute 'matters'
```

To see the list of validations for bills:
```
Bill._validators
#=> validators for bill, this is, the restrictions for certain attributes
```

To check if an object's attributes are valid:

```
bill = Bill.new
bill.valid?
#=> true if all validations are passed, false otherwise
bill.errors.full_messages
#=> validations that are not passed, only exist once bill.valid? is executed
bill.errors.clear
#=> clears list of errors
```

##Working with remote API (HTTP verbs)
This gem provides HTTP methods to your local objects, so that all remote data management is done through object methods. In the following examples, the [Ciudadano Inteligente bill-it installation](http://billit.ciudadanointeligente.org) will be used as the remote API.

###Single Bill

####GET bill
Used to retrieve bill information.
```
bill = Bill.new
bill.get('http://billit.ciudadanointeligente.org/bills/1-07', 'application/json')
```
Now all the '1-07' bill data is stored in 'bill'. You can see all available attributes with:
```
bill.instance_variable_get(:@representable_attrs).collect {|x| x.name if x.instance_of? Representable::Definition}
#=> array with represented bill attributes
```
To access attribute values, for instance the bill title:
```
bill.title
```

####POST (create new bill)

To create a new bill and assign values to its attributes:
```
bill = Bill.new
bill.uid = '0-00'
bill.title = 'new title'
```

To save the bill info on the remote API:
```
bill.post('http://billit.ciudadanointeligente.org/bills', 'application/json')
```

####PUT (modify existing bill)

To retrieve an existing bill and modify its values, for instance add a tag:
```
bill = Bill.new
bill.get('http://billit.ciudadanointeligente.org/bills/0-00', 'application/json')
bill.tags.push('tag')
bill.put('http://billit.ciudadanointeligente.org/bills/0-00', 'application/json')
```

###Bill Collections

Multiple bills can be retrieved in a single action, for instance, when performing a query. This list of bills comes paginated, thus its representer is named bill collection page. This representer can be included in a local model, as with bill representer. This inclusion will soon be made easy as with the BillRepresenter inclusion.
```
require 'billit_representers/representers/bill_collection_page_representer'

class BillCollectionPage < OpenStruct
  include Roar::Representer::Feature::HttpVerbs

  def initialize
    extend Billit::BillCollectionPageRepresenter
    extend Roar::Representer::Feature::Client
    transport_engine = Roar::Representer::Transport::Faraday
  end

  def self
    links[:self].href if links[:self]
  end

  def next
    links[:next].href if links[:next]
  end

  def previous
    links[:previous].href if links[:previous]
  end
end
```

####GET search (search the API)

The following query urls exemplify query syntax and parameters.

* /bills/search.json?q=term
* => search for "term" in all fields
* /bills/search.json?title=hello|hola&tags=world
* => search for bills with a title that contains "hello" or "hola" and with the tag "world"

The result of a query can be retrieved as a bill collection page.
```
bill_page = BillCollectionPage.new
bill_page.get('http://billit.ciudadanointeligente.org/bills/search?q=term', 'application/json')
bill_page.bills
#=> array with resulting bills
```

Query metadata can also be retrieved and accessed via a bill collection page.
```
bill_page.total_entries
#=> number of resulting bills in all pages
bill_page.current_page
#=> current page number
bill_page.total_pages
#=> pages in total
```

You can also access links, like the next and previous page of the query results, and also retrieve them in a bill collection page. Note that in the following example the function next is used because it was defined in the model, but the actual representation access is through links[:next].href.
```
bill_next_page = BillCollectionPage.new
bill_next_page.get(bill_page.next, 'application/json')
```