import 'package:flutter/material.dart';
import 'package:movies/Models/credits_module/credit_response.dart';

class CastWidget extends StatelessWidget {
  CreditResponse? creditResponse;

  CastWidget({
    super.key,
    required this.creditResponse,
  });

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Theme.of(context).colorScheme.onPrimary,
      width: double.infinity,
      height: sizeHeight * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Movie's Cast: ",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 12),
            child: SizedBox(
              width: double.infinity,
              height: sizeHeight * 0.32,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12, top: 12),
                      child: Container(
                        width: 110,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).colorScheme.onPrimary,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.onPrimary),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  3, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child:
                                    creditResponse?.cast?[index].profilePath ==
                                            null
                                        ? const Icon(
                                            Icons.person,
                                            size: 100,
                                          )
                                        : Image.network(
                                            "https://image.tmdb.org/t/p/w500"
                                            "${creditResponse?.cast?[index].profilePath ?? "empty"}",
                                            fit: BoxFit.fill,
                                          )),
                            const SizedBox(height: 5),
                            Text(creditResponse?.cast?[index].name ?? "empty",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            Text("Playing as:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary
                                            .withOpacity(0.5))),
                            Text(
                                creditResponse?.cast?[index].character ??
                                    "empty",
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 16);
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: creditResponse?.cast?.length ?? 0),
            ),
          )
        ],
      ),
    );
  }
}
