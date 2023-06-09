// The agent puts together the driver, sequencer and monitor
class apb_agent extends uvm_agent;
   `uvm_component_utils (apb_agent)

   function new (string name="apb_agent", uvm_component parent);
      super.new (name, parent);
   endfunction

   apb_driver  m_drv;
   apb_monitor m_mon;
   uvm_sequencer #(apb_seq_item) m_seqr; 

   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      m_drv  = apb_driver::type_id::create ("m_drv", this);
      m_mon  = apb_monitor::type_id::create ("m_mon", this);
      m_seqr = uvm_sequencer#(apb_seq_item)::type_id::create ("m_seqr", this);
   endfunction

   virtual function void connect_phase (uvm_phase phase);
      super.connect_phase (phase);
      m_drv.seq_item_port.connect (m_seqr.seq_item_export);
   endfunction
endclass
