import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

usersList(context) {
  double deviceWidth = MediaQuery.of(context).size.width;
  double deviceHeight = MediaQuery.of(context).size.height;
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface.withOpacity(0.65),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.shadow.withOpacity(0.050),
                                spreadRadius: 5.0,
                                blurRadius: 5.0,
                                offset: const Offset(0, 1), // changes position of shadow
                              )
                            ],
                          ),
                          child: TextFormField(
                              style: const TextStyle(fontSize: 12.0),
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 20.0, fontWeight: FontWeight.normal),
                                  labelText: "Search Users",
                                  suffixIcon: IconButton(
                                    onPressed: () => {},
                                    icon: Icon(
                                      Icons.search,
                                      size: 24.0,
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                  ))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Icon(
                Icons.filter_alt_outlined,
                size: 25.0,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  width: deviceWidth * 0.08,
                  child: Text(
                    "#",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  onHover: (value) {},
                  child: Container(
                    width: 15.0,
                    height: 15.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.75),
                        width: 1.0,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Container(),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: deviceHeight * 0.055,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.0),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    "Image".toUpperCase(),
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Name".toUpperCase(),
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Email".toUpperCase(),
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Status".toUpperCase(),
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Options".toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              // smallHorinzontalSpacer(),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 100,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          focusColor: Theme.of(context).colorScheme.error,
                          hoverColor: Theme.of(context).colorScheme.primary,
                          onTap: () {},
                          onHover: (value) {},
                          child: Column(
                            children: [
                              Container(
                                height: deviceHeight * 0.060,
                                margin: const EdgeInsets.only(top: 3.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
                                      spreadRadius: 0,
                                      blurRadius: 0,
                                      offset: const Offset(0, 1), // changes position of shadow
                                    )
                                  ],
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // smallHorinzontalSpacer(),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        // width: deviceWidth * 0.02,
                                        child: Text((index + 1).toString()),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 15.0,
                                        width: 15.0,
                                        alignment: Alignment.center,
                                        // width: deviceWidth * 0.015,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.75), style: BorderStyle.solid, width: 1.0),
                                          // color: Theme.of(context).colorScheme.secondary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Container(),
                                      ),
                                    ),

                                    Expanded(
                                      child: Container(
                                        // width: 20.0,
                                        // height: 20.0,
                                        height: deviceHeight * 0.025,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(255, 255, 255, 0.0),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.error,
                                              image: const DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                    "assets/images/logo.png",
                                                  )),
                                              shape: BoxShape.circle),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        // width: deviceWidth * 0.15,
                                        child: const Text(
                                          "name",
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: deviceWidth * 0.15,
                                        child: const Text(
                                          "Email",
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Transform.scale(
                                          scale: 0.5,
                                          child: CupertinoSwitch(
                                            value: true,
                                            activeColor: Theme.of(context).colorScheme.primary,
                                            onChanged: (bool value) {},
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.more_vert_outlined),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
