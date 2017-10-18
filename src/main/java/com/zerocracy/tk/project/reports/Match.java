/**
 * Copyright (c) 2016-2017 Zerocracy
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to read
 * the Software only. Permissions is hereby NOT GRANTED to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
package com.zerocracy.tk.project.reports;

import com.mongodb.client.model.Aggregates;
import com.mongodb.client.model.Filters;
import com.zerocracy.jstk.Project;
import java.util.Date;
import org.bson.BsonDocument;
import org.bson.codecs.configuration.CodecRegistry;
import org.bson.conversions.Bson;
import org.cactoos.iterable.Joined;
import org.cactoos.list.ListOf;

/**
 * Match.
 *
 * @author Yegor Bugayenko (yegor256@gmail.com)
 * @version $Id$
 * @since 0.18
 * @checkstyle ClassDataAbstractionCouplingCheck (500 lines)
 */
@SuppressWarnings("PMD.AvoidDuplicateLiterals")
final class Match implements Bson {

    /**
     * Project.
     */
    private final Project project;

    /**
     * Start.
     */
    private final Date start;

    /**
     * End.
     */
    private final Date end;

    /**
     * Terms.
     */
    private final Iterable<Bson> terms;

    /**
     * Ctor.
     * @param pkt The project
     * @param left Start
     * @param right End
     * @param items Extra terms
     * @checkstyle ParameterNumberCheck (5 lines)
     */
    Match(final Project pkt, final Date left, final Date right,
        final Bson... items) {
        this(pkt, left, right, new ListOf<>(items));
    }

    /**
     * Ctor.
     * @param pkt The project
     * @param left Start
     * @param right End
     * @param items Extra terms
     * @checkstyle ParameterNumberCheck (5 lines)
     */
    Match(final Project pkt, final Date left, final Date right,
        final Iterable<Bson> items) {
        this.project = pkt;
        this.start = left;
        this.end = right;
        this.terms = items;
    }

    @Override
    public <T> BsonDocument toBsonDocument(final Class<T> type,
        final CodecRegistry reg) {
        return Aggregates.match(
            Filters.and(
                new Joined<Bson>(
                    new ListOf<>(
                        Filters.eq("project", this.project.toString()),
                        Filters.gt("created", this.start),
                        Filters.lt("created", this.end)
                    ),
                    this.terms
                )
            )
        ).toBsonDocument(type, reg);
    }
}
