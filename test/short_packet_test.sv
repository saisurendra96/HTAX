

class short_packet_test extends base_test;

    `uvm_component_utils(short_packet_test)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        uvm_config_wrapper::set(this, "tb.vsequencer.run_phase", "default_sequence", short_packet_vsequence::type_id::get());
        super.build_phase(phase);
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(), "starting new port test",UVM_NONE)
    endtask : run_phase

endclass  : short_packet_test


//////////////////////// Virtual Sequence //////////////////////////

class short_packet_vsequence extends htax_base_vseq;

    `uvm_object_utils(short_packet_vsequence)

    rand int port;
    rand int length;

    function new (string name = "short_packet_vsequence");
        super.new(name);
    endfunction : new

    task body();
       // Exectuing 10 TXNs on ports {0,1,2,3} randomly 
    //fork
    repeat(1500) begin
      port = $urandom_range(0,3);
      //length = $urandom_range(3,10);
      
      //`uvm_do_on(req, p_sequencer.htax_seqr[port])

			//USE `uvm_do_on_with to add constraints on req
        
		`uvm_do_on_with(req, p_sequencer.htax_seqr[port], {req.length inside {[3:10]}; req.delay <=5;} )
        
    end
    //join_none

    endtask : body

endclass    :   random_port_vsequence