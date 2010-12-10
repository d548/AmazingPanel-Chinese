require 'ruby_parser'
require 'pp'
require 'omf/experiments/oedl'

module OMF
  module Experiments  
    class Context      
      include OMF::Experiments::OEDL
      attr_accessor :id, :properties
      def initialize(id)
        @id = id
        @properties = {}
      end

      def getBinding
        return binding
      end
    end
    
    module ScriptHandler
      def self.exec(exp_id, ed)
        script = OMF::Workspace.open_ed(ed.user, ed.name)
        file = OMF::Workspace.ed_for(ed.user, ed.name)
        c = Context.new(exp_id)
        eval(script, c.getBinding(), file)
        pp c 
      end
    end

    # Get the appropiate results for the experiment
    def self.results(experiment)
      ed = experiment.ed
      ed_content = OMF::Workspace.open_ed(ed.user, ed.name)
      parser = OMF::Experiments::OEDLParser.new(ed_content)
      data = OMF::Experiments::GenericResults.new(experiment)
      return { :metrics => parser.getApplicationMetrics(), :results => data }
    end
    
    # Prepare an experiment
    def self.prepare(id)
      begin
        puts "Preparing experiment #{id}"

        images = experiment.sys_images.group(:id).inspect
        images.each do |i|
          nodes = experiment.resources_map.find(:sys_image => i.id)       
        end
        return true
      rescue
        return false
      end
    end

    # Start an experiment
    def self.start
      return true
    end
  end
end

require 'omf/experiments/results'
require 'omf/experiments/ec'
