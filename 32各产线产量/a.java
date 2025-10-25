public boolean processRow(StepMetaInterface smi, StepDataInterface sdi) throws KettleException {
  if (first) {
    first = false;
  }

  Object[] r = getRow();

  if (r == null) {
    setOutputDone();
    return false;
  } 
    String rq=get(Fields.In, "rq").getString(r);
    String bm=get(Fields.In, "bm").getString(r);
    String dw=get(Fields.In, "dw").getString(r);
    String pz=get(Fields.In, "pz").getString(r);
    String gz=get(Fields.In, "gz").getString(r);
    String xs=get(Fields.In, "xs").getString(r);
    int dl=get(Fields.In, "dl").getString(r);
    int js=get(Fields.In, "js").getString(r);
    int zl=get(Fields.In, "js").getString(r);
    String gylx=get(Fields.In, "gylx").getString(r);
  r = createOutputRow(r, data.outputRowMeta.size());

  /* TODO: Your code here. (See Sample)

  // Get the value from an input field
  String foobar = get(Fields.In, "a_fieldname").getString(r);

  foobar += "bar";
    
  // Set a value in a new output field
  get(Fields.Out, "output_fieldname").setValue(r, foobar);

  */
  // Send the row on to the next step.

    String[] arr= gylx.split(",")
    boolean start=false;
    for(int i=0;i<arr.length();i++){
        if(start==false and arr[i].substring(0,2)!=)continue
        
    }
  putRow(data.outputRowMeta, r);

  return true;
}
