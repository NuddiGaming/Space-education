//Skæringspunkt mellem 2 linjer
Punkt skæringspunkt(Linje l1, Linje l2) {
  double x;
  double y;
  //check om der er lodrette linjer
  if (l1.p2.x != l1.p1.x && l2.p2.x != l2.p1.x) {
    double a1 = l1.a();
    double a2 = l2.a();
    double b1 = l1.b();
    double b2 = l2.b();
    //regn x og y ud på skæringspunkt
    x = -((b1-b2)/(a1-a2));
    y = a1*x+b1;
  } else { //hvis der er lodrette linjer
    double a;
    double b;
    //check om det er linje 1 der er lodret
    if (l1.p2.x == l1.p1.x) {
      x = l1.p2.x;
      a = l2.a();
      b = l2.b();
    } else { //hvis det er linje 2
      x = l2.p2.x;
      a = l1.a();
      b = l1.b();
    }
    //regn y ud.
    y = a*x+b;
  }
  return new Punkt(x, y);
}

JSONObject JSONFromLegeme(Legeme legeme) {
  JSONObject j = new JSONObject();
  j.setString("navn", legeme.navn);
  j.setDouble("x", legeme.x*scale);
  j.setDouble("y", legeme.y*scale);
  j.setDouble("radius", legeme.radius*scale);
  j.setDouble("masse", legeme.masse*Math.pow(scale, 2));
  JSONObject farve = new JSONObject();
  farve.setInt("r", int(red(legeme.farve)));
  farve.setInt("g", int(green(legeme.farve)));
  farve.setInt("b", int(blue(legeme.farve)));
  j.setJSONObject("farve", farve);
  return j;
}

Legeme legemeFromJSON(JSONObject legemeJSON) {
  Legeme legeme = new Legeme(legemeJSON.getDouble("x"), legemeJSON.getDouble("y"), legemeJSON.getDouble("radius"), 
  legemeJSON.getDouble("masse"), color(legemeJSON.getJSONObject("farve").getInt("r"), 
  legemeJSON.getJSONObject("farve").getInt("g"), legemeJSON.getJSONObject("farve").getInt("b")),legemeJSON.getString("navn"));
  return legeme;
}

void saveScenario(String name) {
  JSONArray legemerJSON = new JSONArray();
  for (Legeme legeme : legemer) {
    legemerJSON.append(JSONFromLegeme(legeme));
  }

  scenario = new JSONObject();
  scenario.setJSONArray("legemer", legemerJSON);

  JSONObject raketJSON = new JSONObject();
  raketJSON.setDouble("x", raket.x);
  raketJSON.setDouble("y", raket.y);
  raketJSON.setDouble("vX", raket.vX);
  raketJSON.setDouble("vY", raket.vY);
  raketJSON.setDouble("rot", raket.rot);
  raketJSON.setDouble("rotHast", raket.rotHast);
  raketJSON.setDouble("brænd mængde", raket.brændMængde);

  scenario.setJSONObject("raket", raketJSON);
  scenario.setDouble("scale", scale);

  saveJSONObject(scenario, "data/scenarios/"+name+".json");
}

void loadScenario(String navn) {
  legemer.clear();
  JSONObject scenario = loadJSONObject("data/scenarios/"+navn+".json");
  
  JSONObject raketJSON = scenario.getJSONObject("raket");
  raket.x = raketJSON.getDouble("x");
  raket.y = raketJSON.getDouble("y");
  raket.vX = raketJSON.getDouble("vX");
  raket.vY = raketJSON.getDouble("vY");
  raket.rot = raketJSON.getDouble("rot");
  raket.rotHast = raketJSON.getDouble("rotHast");
  raket.brændMængde = raketJSON.getDouble("brænd mængde");
  
  scale = scenario.getDouble("scale");
  JSONArray legemerJSON = scenario.getJSONArray("legemer");
  for (int i=0; i<legemerJSON.size(); i++) {
    JSONObject legemeJSON = legemerJSON.getJSONObject(i);
    Legeme legeme = legemeFromJSON(legemeJSON);
  }
}

void tegnPil(Punkt pos, double længde, double bredde, double pilHøjde, double v, color farve){
  Punkt pos2 = new Punkt(pos.x, pos.y-længde);
  Punkt pil1 = new Punkt(pos.x-bredde/2, pos2.y+pilHøjde);
  Punkt pil2 = new Punkt(pos.x+bredde/2, pos2.y+pilHøjde);
  pos2 = pos2.rotate(pos, v);
  pil1 = pil1.rotate(pos, v);
  pil2 = pil2.rotate(pos, v);
  stroke(farve);
  strokeWeight(10);
  strokeCap(ROUND);
  line((float)pos.x, (float)pos.y, (float)pos2.x, (float)pos2.y);
  line((float)pos2.x, (float)pos2.y, (float)pil1.x, (float)pil1.y);
  line((float)pos2.x, (float)pos2.y, (float)pil2.x, (float)pil2.y);
  stroke(0);
  strokeWeight(2);
  noStroke();
}
