# Logstash Plugin


This is a plugin for [Logstash](https://github.com/elastic/logstash).


## Documentation

Logstash provides infrastructure to automatically generate documentation for this plugin. We use the asciidoc format to write documentation so any comments in the source code will be first converted into asciidoc and then into html. All plugin documentation are placed under one [central location](http://www.elastic.co/guide/en/logstash/current/).

- For formatting code or config example, you can use the asciidoc `[source,ruby]` directive
- For more asciidoc formatting tips, see the excellent reference here https://github.com/elastic/docs#asciidoc-guide

## Why this plugin

When setting up logging stacks, we weren't able to use the solr_http output plugin in logstash conf to talk to solr
On the other hand, we found SiLK 1.5 stack is shipping its own customized version of logstash, which is a java jar file.
Though the example provided with customized version of [SiLK logstash](https://docs.lucidworks.com/display/SiLK/Solr+Writer+for+Logstash+Initial+Setup) was able to pipe events to solr server, our needs were

1. We already had a logstash server running for a while and it had a great ecosystem of input, filter and outpput plugins
2. We would like to use this existing logstash server and NOT have to re-invent the wheel

Specifically, we want the same logstash server (that elastic search provides) to work with solr. It should be as simple as install a plugin, write the output conf and see the pipeline work, by viewing the events on the other side of solr

## How does this plugin do it  

It is possible to do a simple http POST to solr end point and post documents. Hence, we wrote simple logic extending logstash output base class and POST the event to solr endpoint. Of course, since solr expects the http post payload to be in a certain format, we format the event and then directly do a POST. That is it! 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
